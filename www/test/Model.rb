
class Field
  attr_reader :name, :caption, :type

  def initialize(name, caption, type)
    @name = name
    @caption = caption
    @type = type
  end

  def to_h
    Hash[instance_variables.map { |var| [var[1..-1].to_sym, instance_variable_get(var)] }]
  end

  def to_json
    to_h.to_json
  end

end

class ReferenceField < Field
  attr_reader :outer_table, :outer_field, :link_table, :link_fields, :options

  def initialize(name, caption, type, outer_table, outer_field, link_table, link_fields)
    super(name, caption, type)
    @outer_table = outer_table
    @outer_field = outer_field
    @link_table = link_table
    @link_fields = link_fields
    @options = []
  end

  def set_options(connection)
    sql = "Select id, #{outer_field} From #{outer_table}"
    sth = connection.prepare(sql)
    sth.execute
    @options = []
    sth.fetch{|row|
      @options << row.to_a
    }
    sth.finish
  end

end

class Model

  attr_reader :name

  def required_params
    params = []
    @images_fields = []
    @fields.each{|field|
      @images_fields.push(field) if field.type == 'Image'
      next if field.name == 'id'
      params.push(field.name)
    }
    params
  end

  def initialize(name, fields, refers = [])
    @name = name
    @fields = fields
    @refers = refers
  end

  def add_links(params,connection)
    @refers.each{|refer|
      sql = "Insert into #{refer.link_table} (#{refer.link_fields*','}) values (lastval(),?)"
      params.params[refer.name].each{|r_param|
        sth = connection.prepare(sql)
        sth.execute(r_param)
        sth.finish
      }
    }
  end

  def add_images(params)
    require 'time'
    require_relative 'Image'
    @images_fields.each{|field|
      link = "#{Time.now.nsec}.#{params[field.name].original_filename.split.last}"
      File.open('images\\' + link, 'wb'){ |file| file.write params[field.name].read }
      Image.create_thumb(params[field.name], link)
      params.params[field.name] = [link]
    }
  end

  def add(params, connection)
    req_params = required_params
    sql = "Insert into #{@name} (#{req_params*','}) values (#{'?,'*(req_params.size - 1) + '?'})"
    add_images(params)
    prepare_and_execute(connection, sql, req_params,params)
    add_links(params, connection)
  end

  def update_links(params, connection)
    @refers.each{|refer|
      req_params = ['id']
      sql = "Delete from #{refer.link_table} where #{refer.link_fields[0]} = ?"
      prepare_and_execute(connection, sql, req_params,params)
      sql = "Insert into #{refer.link_table} (#{refer.link_fields*','}) values (?,?)"
      params.params[refer.name].each{|r_param|
        sth = connection.prepare(sql)
        sth.execute(params['id'],r_param)
        sth.finish
      }
    }
  end

  def update(params, connection)
    req_params = required_params
    sql = "update #{@name} set #{req_params*' = ?, ' + ' = ?'} where id = ?"
    prepare_and_execute(connection, sql, required_params.push('id'),params)
    update_links(params, connection)
  end

  def delete(params, connection)
    req_params = ['id']
    sql = "Delete from #{@name} where id = ?"
    delete_images(params, connection)
    prepare_and_execute(connection, sql, req_params,params)
  end

  def delete_images(params, connection)
    return if @images_fields.size == 0
    sql = "Select * from #{name} where id in (#{params['id']}*',')"
    sth = connection.prepare(sql)
    sth.execute(*params.params['id'])
    rows = []
    sth.fetch{|row|
      rows << row.to_h
    }
    sth.finish
    rows.each{|row|
      File.delete('images\\' + row[field.name])
      File.delete('images\thumb\\' + row[field.name])
    }
  end

  def select(connection, as_array = true)
    fields = @fields.map{|field|
      "#{@name}.#{field.name}"
    }
    joins = ''
    aliases = []
    i = 0
    refers = @refers.map{|refer|
      aliases.push("a#{i}")
      joins += " left join #{refer.link_table} on #{refer.link_table}.#{refer.link_fields[0]} = #{@name}.id " +
          " left join #{refer.outer_table} a#{i} on #{refer.link_table}.#{refer.link_fields[1]} = a#{i}.id "
      i += 1
      "array_agg(#{refer.link_table}.#{refer.link_fields[1]})"
    }
    sql = "Select #{fields * ', '}#{', ' unless refers.empty?} #{refers*', '} From #{@name} #{joins} #{'Group by '+@name+'.id' unless refers.empty?}"
    sth = connection.prepare(sql)
    sth.execute
    rows = []
    sth.fetch{|row|
      rows << (as_array ? row.to_a : row.to_h)
    }
    sth.finish
    rows
  end

  def prepare_and_execute(connection,sql,req_params,params)
    par = req_params.map{|req_param|
      params[req_param]

    }
    sth = connection.prepare(sql)
    sth.execute(*par)
  end

  def get_all_fields(connection)
    (@fields + @refers).each{|field|
      if field.type == 'Refer_String' || field.type == 'Array'
        field.set_options(connection)
      end
    }
  end

end

class Categories < Model

  def select(connection)
    fields = @fields.map{|field|
      "#{@name}.#{field.name}"
    }
    sql = "Select #{fields * ', '} From #{@name} order by #{@name}.id"
    sth = connection.prepare(sql)
    sth.execute
    data = {}
    sth.fetch{|row|
      data[row['parent_id']] = [] if data[row['parent_id']] == nil
      data[row['parent_id']] << row.to_h
    }
    sth.finish
    data
  end

end

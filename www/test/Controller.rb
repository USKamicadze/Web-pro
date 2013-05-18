#encoding: UTF-8
require 'haml'
require 'json'

class Controller

  def initialize(model, view)
    @model = model
    @view = view
  end

  def action(act, params, connection)
    case act
      when 'add' then @model.add(params, connection)
      when 'update' then @model.update(params, connection)
      when 'delete' then @model.delete(params, connection)
    end
  end

  def show(cgi, connection)
    params = get_params(connection)
    @view.show(cgi,params)
  end

  def get_params(connection)
    {
      :table => @model.name,
      :fields => @model.get_all_fields(connection),
      :rows => @model.select(connection),
    }
  end

end

class Categories_Controller < Controller

  def get_params(connection)
    {
      :table => @model.name,
      :tree => @model.select(connection).to_json,
      :fields => @model.get_all_fields(connection)
    }
  end

end

class Image_Controller < Controller

  def get_params(connection)
    {
        :table => @model.name,
        :fields => @model.get_all_fields(connection),
        :rows => @model.select(connection, false),
    }
  end

end
#!C:\RailsInstaller\Ruby1.9.3\bin\ruby.exe
#encoding: windows-1251

require 'dbi'
require 'cgi'


cgi = CGI.new(:accept_charset => 'windows-1251', :tag_maker => 'html4')

def cgi.field(caption, for_input, input)
  self.div(:class => 'field'){self.label(:for => for_input){caption+':'} + input}
end

begin
  dbh = DBI.connect('DBI:Pg:dbname=GOODS;host=localhost','postgres','masterkey')
  unless cgi['add'].empty?
    sth = dbh.prepare('INSERT INTO goods (name, type, price) VALUES (?,?,?)')
    params = cgi['name'], cgi['type'], cgi['price']
    message = 'Добавление выполнено успешно'
  end
  unless cgi['update'].empty?
    sth = dbh.prepare('UPDATE goods SET name = ?, type = ?, price = ? WHERE id = ?')
    params = cgi['name'], cgi['type'], cgi['price'], cgi['id']
    message = 'Успешно изменено'
  end
  unless cgi['delete'].empty?
    sth = dbh.prepare('DELETE FROM goods WHERE id = ?')
    params = [cgi['id']]
    message = 'Успешно удалено'
  end
  if sth
    params.map!{|value|
      if (value == '')
        value = 0
      end
      value
    }
    sth.execute(*params)
    sth.finish
    dbh.commit

  end
  table_content = cgi.thead{
    cgi.tr{
      cgi.th{'ID'}+
      cgi.th{'Название'}+
      cgi.th{'Тип'}+
      cgi.th{'Цена'}+
      cgi.th
    }
  }
  sth = dbh.prepare 'SELECT * FROM goods'
  sth.execute
  sth.fetch{|row|
    onclick = "show_update_form('#{row[:id]}', '#{row[:name]}', '#{row[:type]}', '#{row[:price]}')"
    table_content += cgi.tr{
      cgi.td(:onclick => onclick) { row[:id] } +
      cgi.td(:onclick => onclick) { row[:name] } +
      cgi.td(:onclick => onclick) { row[:type] } +
      cgi.td(:onclick => onclick) { row[:price] } +
      cgi.td { cgi.a(:class => 'minimal', :href => "/cgi-bin/testdbi.rb?delete=delete&id=#{row[:id]}"){ 'Удалить' } }
    }
  }
  sth.finish
rescue DBI::DatabaseError => e
  error =
    cgi.p{'Произошла ошибка'}+
    cgi.p{"Код ошибки:   #{e.err}"}+
    cgi.p{"Текст ошибки: #{e.errstr}"}
ensure
  dbh.disconnect if dbh
end
if error
  cgi.out{ cgi.html{error} }
else
  cgi.out('type' => 'text/html', 'charset' => 'windows-1251'){
    cgi.html{
      cgi.head{
        cgi.meta('http-equiv' => "Content-Type", :content => "text/html; charset=windows-1251")+
        cgi.title{'Goods'} +
        cgi.link(:rel => 'stylesheet', :type => 'text/css', :href => '/js/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.css') +
        cgi.link(:rel => 'stylesheet', :type => 'text/css', :href => '/css/style.css') +
        cgi.script(:src => '/js/jquery-ui-1.10.0.custom/js/jquery-1.9.0.js') +
        cgi.script(:src => '/js/jquery-ui-1.10.0.custom/js/jquery-ui-1.10.0.custom.js') +
        cgi.script(:src => '/js/TestDB.js')
      } +
      cgi.body{
        cgi.table(:id => 'goods'){ table_content } +
        cgi.button(:class => 'minimal', :id => 'add_button', :onclick => 'show_add_form()'){'Добавить'} +
        cgi.form(:id => 'add', :method => 'post', :action => '/cgi-bin/testdbi.rb', 'accept-charset' => 'windows-1251'){
          cgi.field('Название','name',cgi.input(:type => 'text', :name => 'name')) + cgi.br +
          cgi.field('Тип','type',cgi.input(:type => 'text', :name => 'type')) + cgi.br +
          cgi.field('Цена','price',cgi.input(:class => 'num_filter',:type => 'text', :name => 'price')) + cgi.br +
          cgi.input(:class => 'minimal', :type => 'submit', :name => 'add', :value => 'Добавить') +
          cgi.input(:class => 'minimal', :type => 'button', :onclick => 'hide_form(af)', :value => 'Отмена')
        }+
        cgi.form(:id => 'update', :method => 'post', :action => '/cgi-bin/testdbi.rb', 'accept-charset' => 'windows-1251'){
          cgi.field('ID','id',cgi.input(:type => 'text', :name => 'id', :disabled => '1')) + cgi.br +
          cgi.field('Название','name',cgi.input(:type => 'text', :name => 'name')) + cgi.br +
          cgi.field('Тип','type',cgi.input(:type => 'text', :name => 'type')) + cgi.br +
          cgi.field('Цена','price',cgi.input(:class => 'num_filter', :type => 'text', :name => 'price')) + cgi.br +
          cgi.input(:type => 'hidden', :name => 'id') +
          cgi.input(:class => 'minimal', :type => 'submit', :name => 'update', :value => 'Изменить') +
          cgi.input(:class => 'minimal', :type => 'button', :onclick => 'hide_form(uf)', :value => 'Отмена')
        } + cgi.p(:id => 'message'){message}
      }
    }
  }
end




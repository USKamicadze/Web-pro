#!C:\RailsInstaller\Ruby1.9.3\bin\ruby.exe
#encoding: windows-1251

require 'dbi'
require 'cgi'
require 'haml'


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
  sth = dbh.prepare('SELECT * FROM goods')
  sth.execute
  rows = []
  sth.fetch{|row|
    rows << row.to_h
  }
  sth.finish
rescue DBI::DatabaseError => e
  error = e
ensure
  dbh.disconnect if dbh
end
#Dir.chdir(File.dirname(__FILE__))
cgi.out('type' => 'text/html', 'charset' => 'windows-1251'){
  Haml::Engine.new(File.read('bd.haml',:encoding => 'windows-1251')).render(Object.new,
    :error => error,
    :rows => rows,
    :message => message
  )
}





require 'dbi'

def connect
  DBI.connect('DBI:Pg:dbname=WebShop;host=localhost','postgres','masterkey')
end
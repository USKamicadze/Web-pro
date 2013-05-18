#!C:\Ruby200-x64\bin\ruby.exe
#encoding: UTF-8

require 'dbi'
require 'cgi'
require_relative 'Dispacher'

cgi = CGI.new(:tag_maker => 'html4')
dbh = DBI.connect('DBI:Pg:dbname=WebShop;host=localhost','postgres','masterkey')

dispatcher = Dispatcher.new(cgi, dbh)
dispatcher.action
dispatcher.show_page









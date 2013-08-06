#!C:\Ruby200-x64\bin\ruby.exe
#encoding: UTF-8


require 'cgi'
require_relative 'connect'
require_relative 'Dispacher'

cgi = CGI.new(:tag_maker => 'html4')
dbh = connect()

dispatcher = Dispatcher.new(cgi, dbh)
dispatcher.action
dispatcher.show_page









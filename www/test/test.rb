#!C:\Ruby200-x64\bin\ruby.exe
require 'dbi'
require 'cgi'

cgi = CGI.new(:tag_maker => 'html4')

cgi.out{__dir__ + "<br>" + Dir.home(__dir__)}
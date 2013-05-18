require 'dbi'
require 'cgi'

cgi = CGI.new(:tag_maker => 'html4')

cgi.out{__dir__}
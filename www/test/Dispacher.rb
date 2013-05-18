#!C:\Ruby200-x64\bin\ruby.exe
#encoding: UTF-8
require_relative 'Consts.rb'
class Dispatcher

  def initialize(cgi,connection)
    if cgi['table'].empty?
      cgi.params['table'] = ['goods']
    end
    @cgi = cgi
    @connection = connection
    @controller = CONTROLLERS[cgi['table']]
  end

  def action
    begin
      @controller.action(@cgi['action'], @cgi, @connection) unless @cgi['action'].empty?
      @connection.commit
    rescue DBI::DatabaseError => e
      @connection.rollback
      print "Content-type: text/plain; charset=UTF-8\n\n"
      print e
      Kernel.exit
    end
  end

  def show_page
    @controller.show(@cgi, @connection)
  end

end

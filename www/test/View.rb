#!C:\Ruby200-x64\bin\ruby.exe
#encoding: UTF-8

class View
  @template
  attr_reader :names

  def initialize (file_name)
    @template = File.read('templates/' + file_name,:encoding => 'UTF-8')
  end

  def show(cgi, params)
    cgi.out('type' => 'text/html', 'charset' => 'UTF-8'){
      Haml::Engine.new(@template).render(
          Object.new,
          params
      )
    }
  end

end
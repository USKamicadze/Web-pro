#!C:\RailsInstaller\Ruby1.9.3\bin\ruby.exe
#encoding: windows-1251
require 'cgi'
require 'date'

cgi = CGI.new('html4')
if !cgi.params['date'].empty?
  begin
    date1, date2 = cgi.params['date'].map{|str_date| Date.parse(str_date)}
    message = "�������� ����� #{date1.to_s} � #{date2.to_s}: #{(date1 - date2).to_i.abs.to_s} ����"
  rescue
    message = '������ ������� ����'
  end
end

cgi.out('type' => 'text/html', 'charset' => 'WINDOWS-1251'){
  cgi.html {
    cgi.head { cgi.title { '�������� ���' } } +
    cgi.body {
      cgi.form {
        cgi.input('type' => 'date', 'name' => 'date', 'value' => date1)  +
        cgi.input('type' => 'date', 'name' => 'date', 'value' => date2)  +
        cgi.submit('�������!')
      } +
      cgi.p { message }
    }
  }
}
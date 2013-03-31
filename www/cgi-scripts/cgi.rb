#!C:\RailsInstaller\Ruby1.9.3\bin\ruby.exe

require 'cgi'
require 'date'

cgi = CGI.new 'html4'
unless cgi['submit'].empty?
  arr = cgi.params['date']
  if arr[0].length != 0 && arr[1].length != 0
    t = arr.map{|x| Date.parse x}
    diff = (t[0] - t[1]).to_i.abs
    msg = "Difference between received dates is #{diff} day(s)"
  else
    msg = 'Invalid dates was submitted.'
  end
end
content = cgi.html do
            cgi.head { cgi.title { 'Difference between dates' } } +
              cgi.body do
                cgi.form do
                    cgi.input(:type => 'date', :name => 'date', :value => (arr[0] if arr)) +
                    cgi.input(:type => 'date', :name => 'date', :value => (arr[1] if arr)) +
                    cgi.submit('Calculate!', 'submit')
                end +
                cgi.p { msg }
              end
          end
cgi.out { CGI::pretty content, "\t"}
#!C:\RailsInstaller\Ruby1.9.3\bin\ruby.exe

require 'fb'

include Fb

require 'cgi'

cgi = CGI.new()
db = Database.new(
    :database => "localhost:D:/USKamicadze/DVFUUUU/IT/Server/SDB/STOREDB.fdb",
    :username => 'sysdba',
    :password => 'masterkey'
)
conn = db.connect rescue db.create.connect
unless cgi['add'].empty?
     conn.execute('INSERT INTO GOODS (ID, NAME, TYPE, COST) VALUES (GEN_ID(GOODS,1),?,?,?)', cgi['NAME'], cgi['TYPE'], cgi['COST'])
end
unless cgi['update'].empty?
  conn.execute('UPDATE GOODS SET NAME = ?, TYPE = ?, COST = ? WHERE ID = ?', cgi['NAME'], cgi['TYPE'], cgi['COST'], cgi['ID'])
end
unless cgi['delete'].empty?
  conn.execute('DELETE FROM GOODS WHERE ID = ?', cgi['ID'])
end
ary = conn.query(:hash, "SELECT * FROM GOODS ")
headers = ary[0].keys
tabh = <<header
  <tr>
      <td>#{headers[0]}</td>
      <td>#{headers[1]}</td>
      <td>#{headers[2]}</td>
      <td>#{headers[3]}</td>
   </tr>
header
tabc = ''
ary.each {|row|
  fields = ''
  row.each{|key, value| fields+= "<td>#{value}</td>"}
  fields +="<td><a href='http://localhost:8080/cgi-bin/test2.rb?delete=delete&ID=#{row['ID']}'>Delete</a></td>"
  tabc +="<tr class = 'item'>#{fields}</tr>\n"

}
mytable = <<table
<table border = "1">
    #{tabh}
    #{tabc}
</table>
table
h = <<ht
<html>
    <head>
        <title>DB TEST</title>
        <link rel="stylesheet" type="text/css" href="http://localhost:8080/js/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.css">
        <script src="http://localhost:8080/js/jquery-ui-1.10.0.custom/js/jquery-1.9.0.js"></script>
        <script src="http://localhost:8080/js/jquery-ui-1.10.0.custom/js/jquery-ui-1.10.0.custom.js"></script>
        <script src="http://localhost:8080/js/TestDB.js"></script>
    </head>
    <body onload = load()>
        <form method="post" action="/cgi-bin/test2.rb">
          #{mytable}
        </form>
          <button onclick="addclick()">Add</button>
          <form id="add" method="post" action="/cgi-bin/test2.rb" accept-charset="WINDOWS-1251" style="display: none">
            <input type="hidden" name="ID"/> </br>
            <input type="text" name="NAME"/> </br>
            <input type="text" name="TYPE"/> </br>
            <input type="text" name="COST"/> </br>
            <input type="submit" name="add" value="add"/> </br>
          </form>
          <form id="update" method="post" action="/cgi-bin/test2.rb" accept-charset="WINDOWS-1251" style="display: none">
            <input type="hidden" name="ID"/> </br>
            <input type="text" name="NAME"/> </br>
            <input type="text" name="TYPE"/> </br>
            <input type="text" name="COST"/> </br>

            <input type="submit" name="update" value="update"/> </br>
          </form>
        </body>
</html>
ht
puts "Content-Type: text/html\r\n\r\n"
puts h


conn.close











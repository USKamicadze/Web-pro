#! C:\strawberry\perl\bin\perl.exe
$j = substr($ENV{'QUERY_STRING'},10);
print "Content-type: text/plain\r\n\r\n";
print "Привет $j";
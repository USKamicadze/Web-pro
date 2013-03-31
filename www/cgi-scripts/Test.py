#! C:\Python32\python.exe
# -*- coding:WINDOWS-1251 -*-

import cgi
from datetime import datetime

form = cgi.FieldStorage(keep_blank_values = True)
message = ''
if form.getlist('date'):
    dates = [(datetime.strptime(date, "%Y-%m-%d")) for date in form.getlist('date') if len(date) > 0]
    if len(dates) == 2 :
        message = "<p> �������� ��� ����� {} � {}: {} ����</p>".format( dates[0].strftime("%Y-%m-%d"),
                                                                        dates[1].strftime("%Y-%m-%d"),
                                                                        abs((dates[0] - dates[1]).days))
    else:
        message ="<p> ��� ��������� � ������, ������ ������ �� ����.</p>"

print("Content-Type: text/html; charset=WINDOWS-1251\r\n\r\n")

html = """
<html>
    <head>
        <title>�������� ���</title>
    </head>
    <body>
        <form method="post">
            <input type="date" name="date">
            <input type="date" name="date">
            <input type="submit" value="�������!">
        </form>
        {}
    </body>
</html>
""".format(message)
print (html)


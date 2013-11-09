
function testmessage(message){
    $('#message').text(message)
    $('#message-dialog').dialog({
        modal: true,
        buttons: {
            Ok: function() {
                $( this ).dialog( "close" )
            }
        }
    })
}
function PrepareGrid(fields) {
    PrepareForms();
    var colNam = []
    var colMod = []
    for (var key in fields){
        colNam.push(fields[key].caption)
        colMod.push({
            name: fields[key].name
        })
    }
    tableToGrid('#content_table',{
        url: '/test/index.rb',
        height: 500,
        mtype: 'POST',
        rowNum: 20,
        pager: $('#table_pager'),
        colNames: colNam,
        colModel: colMod,
        ondblClickRow: function (id){
            var data =  $(this).getRowData(id)
            var d = []
            for(var i in data){
                d.push(data[i])
            }
            updateForm.fill(d)
            updateForm.show()
            //testmessage($(this).getRowData(id))
            objDump($(this).getRowData(id))
            //$(this).editGridRow( id );
        }

    })
}



function DeleteImg(id) {
    $( "#dialog-confirm" ).dialog({
        resizable: false,
        height:140,
        modal: true,
        position: 'top',
        buttons: {
            "Да": function() {
                $.post('/test/bd.rb', {table: 'images', action: 'delete', id:id})
                $('div[img_id='+id+']').remove()
                $( this ).dialog( "close" );
            },
            "Нет": function() {
                $( this ).dialog( "close" );
            }
        }
    });
}

function UpdateImg(data){
   updateForm.fill(data)
   var pos = $('div[img_id='+data[0]+']').position()
   pos.left += 150
   updateForm.show(pos)
}

$(document).ready(function(){
    PrepareForms();
})
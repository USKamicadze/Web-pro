
function DeleteImg(id) {
    $( "#dialog-confirm" ).dialog({
        resizable: false,
        height:140,
        modal: true,
        position: [300,300],
        buttons: {
            "Да": function() {
                $.post('/test/index.rb', {table: 'images', action: 'delete', id:id})
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

function ShowFullImage(file_name){
   location.href = '/images/'+file_name
}

$(document).ready(function(){
    PrepareForms();
})
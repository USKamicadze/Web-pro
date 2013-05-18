
function DeleteImg(id) {
    $( "#dialog-confirm" ).dialog({
        resizable: false,
        height:140,
        modal: true,
        buttons: {
            "Да": function() {
                $.post('/test/bd.rb', {table: 'images', action: 'delete', id:id})
                location.reload();
                $( this ).dialog( "close" );
            },
            "Нет": function() {
                $( this ).dialog( "close" );
            }
        }
    });
}

    $(document).ready(function(){
        PrepareForms();
        //PrepareImages();
    })
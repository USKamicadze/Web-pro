
var oldid = -1
var af;
var uf;
var ab;
function show_add_form(){
    af.style.display = 'block'
	hide_form(uf)
	ab.style.display = 'none'
}

function hide_form(form){
    form.style.display = 'none'
	if (af.style.display == 'none' && uf.style.display == 'none')
		ab.style.display = 'block'
}

function show_update_form(id, name, type, price){
	hide_form(af)
	ab.style.display = 'none'
	uf[0].value = id
	uf[1].value = name
	uf[2].value = type
	uf[3].value = price
	uf[4].value = id
    var newid = id
	if (oldid == newid){
		uf.style.display = 'none'
		oldid = -1
	} else {
		uf.style.display =  'block'
		oldid = newid
	}
}

function message(caption, color){
	$('#message').text(caption)
	var top = 30
	if (af.style.display == 'block')
		top = 190
	if (uf.style.display == 'block')
		top = 230
	$('#message').css({top: top})
	$('#message').css('display','block')
	$('#message').css('color',color)
	$('#message').fadeOut(2000)
}

function check_form(){
	for(var i = 0; i < 4; ++i)
		if(this[i].value == ''){
			message('Заполните все поля!', '#FF0000')
			return false
		}
}



$(document).ready(function() {
    $(".num_filter").keydown(function(event) {
        if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || 
            (event.keyCode == 65 && event.ctrlKey === true) || 
            (event.keyCode >= 35 && event.keyCode <= 39)) {
                 return;
        }
        else {
            if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
                event.preventDefault(); 
            }   
        }
    });
	af = document.getElementById('add')
	uf = document.getElementById('update')
	ab = document.getElementById('add_button')
	message($('#message').text(), '#00FFaa')
	af.onsubmit = check_form
	uf.onsubmit = check_form
});

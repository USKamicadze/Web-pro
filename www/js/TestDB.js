
var oldid = -1
var af;
var uf;
var ab;
var form_size = 0;
function show_add_form(){
    af.style.display = 'block'
	hide_form(uf)
	ab.style.display = 'none'
	form_size = af.offsetHeight
}

function hide_form(form){
    form.style.display = 'none'
	if (af.style.display == 'none' && uf.style.display == 'none')
		ab.style.display = 'block'
}

function show_update_form(args){
	hide_form(af)
	ab.style.display = 'none'
	for (var i = 0; i < args.length; ++i){
		if (args[i] instanceof Array){
			for(var j = 0; j < uf[i].options.length; ++j){
				uf[i].options[j].selected = false
				if (args[i].indexOf(parseInt(uf[i].options[j].value)) != -1)
					uf[i].options[j].selected = true
			}
		}else
			uf[i].value = args[i]
	}
	var newid = args[0]
	if (oldid == newid){
		hide_form(uf)
		oldid = -1
	} else {
		uf.style.display =  'block'
		oldid = newid
	}
	form_size = uf.offsetHeight
}

function message(caption, color){
	$('#message').text(caption)
	var top = form_size + 25
	$('#message').css({top: top})
	$('#message').css('display','block')
	$('#message').css('color',color)
	$('#message').fadeOut(2000)
}

function check_form(){
	for(var i = 0; i < this.elements.length; ++i)
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

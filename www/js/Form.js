
function FormCancel(event){
    event.data.form.hide()
}

function FormSubmit(event){
    for(var i = 0; i < this.elements.length; ++i)
        if(this[i].value == ''){
            alert('Заполните все поля!')
            return false
        }
}

function Form(selector){
    this.form = $(selector).submit()
    this.form.zIndex(100)
    this.form.submit(FormSubmit)
    this.test = $(selector + ' input.cancel').click({form: this}, FormCancel)
}

Form.prototype.show = function(position){
    this.form.fadeIn()
    this.form.offset({top: position.top, left: position.left})
}

Form.prototype.hide = function(){
    this.form.fadeOut()
}

Form.prototype.fill = function(data){
    for (var i = 0; i < data.length; ++i){
        if (data[i] instanceof Array){
            for(var j = 0; j < this.form[0][i].options.length; ++j){
                this.form[0][i].options[j].selected = false
                if (data[i].indexOf(parseInt(this.form[0][i].options[j].value)) != -1)
                    this.form[0][i].options[j].selected = true
            }
        }else
            this.form[0][i].value = data[i]
    }
}

function extend(Child, Parent) {
    Child.prototype = new Parent()
    Child.prototype.constructor = Child
    Child.superclass = Parent.prototype
}

function AddClick(event){
    var pos = $(this).position()
    pos.left -= 200
    event.data.form.show(pos)
}

function AddForm(selector, button_selector){
    AddForm.superclass.constructor.call(this,selector)
    this.add_button = $(button_selector).click({form: this}, AddClick)
}

extend(AddForm, Form)

AddForm.prototype.show = function(position){
    AddForm.superclass.show.call(this,position)
    this.add_button.fadeOut()
}

AddForm.prototype.hide = function(){
    AddForm.superclass.hide.call(this)
    this.add_button.fadeIn()
}

/*
var oldid = -1
var af
var uf
var ab
var form_size = 0
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

function fill(data){

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
 */

function NumFilter(event){
    if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 ||
       ( event.keyCode >= 35 && event.keyCode <= 39) || ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )))
        return
}

function SetNumFilters(){
    $(".num_filter").keydown(NumFilter)
}

function PrepareForms(){
    SetNumFilters()
    addForm = new AddForm('form#add', 'button#add_button')
    updateForm = new Form('form#update')
    //addbutton =
}

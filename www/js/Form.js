
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
    this.form = $(selector).submit().draggable()
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

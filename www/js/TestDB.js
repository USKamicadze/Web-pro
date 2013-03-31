/**
 * Created with JetBrains WebStorm.
 * User: Uskamikadze
 * Date: 20.03.13
 * Time: 1:20
 * To change this template use File | Settings | File Templates.
 */
var oldid = -1
function addclick(){
    var form = document.getElementById('add')
    form.style.display = (form.style.display == 'block')?'none':'block'
}
function itemclick(){
    var form = document.getElementById('update')
    for(var i = 0; i < 4; ++i)
        form[i].value = this.parentElement.children[i].innerText
    var newid = form[0].value
    form.style.display =  (oldid == newid && form.style.display == 'block')?'none':'block'
    oldid = newid
}
function load(){
    $(".item td").click(itemclick)
}

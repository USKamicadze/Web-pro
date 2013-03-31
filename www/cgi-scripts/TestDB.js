/**
 * Created with JetBrains WebStorm.
 * User: Uskamikadze
 * Date: 20.03.13
 * Time: 1:20
 * To change this template use File | Settings | File Templates.
 */
function itemclick(){
    var form = document.getElementById('update')
    for(var i = 0; i < 4; ++i)
        form[i].value = this.parentElement.children[i].innerText
}
function load(){
    $(".item td").click(itemclick)
}

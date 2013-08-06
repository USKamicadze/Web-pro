(function($){
    jQuery.fn.Tree = function(data){
        var obj = this
        var Build = function (root, category, parent_id){
            var node = $('<ul/>')
            var len = category[parent_id].length
            $(root).append(node).append(sliger)
            for(var i = 0; i < len; ++i){
                if (category[parent_id][i]['id'] == category[parent_id][i]['parent_id'])
                    continue
                var c = $('<li/>').append($('<div/>',{
                    class: 'tree_content',
                    text: category[parent_id][i]['name']+' (id: '+category[parent_id][i]['id']+')'
                }).click({id: category[parent_id][i]['id'], name: category[parent_id][i]['name'], parent_id: category[parent_id][i]['parent_id']},
                    function (e){
                        updateForm.fill([e.data.id, e.data.name, e.data.parent_id])
                        updateForm.show({top:e.pageY, left:e.pageX})
                    }
                ))
                c.append($('<div/>', {
                        class: 'button delete'
                    }).click({id: category[parent_id][i]['id'], obj: c}, function(e){
                        $.post('/test/index.rb', {table: gtable, action: 'delete', id:e.data.id})
                        e.data.obj.remove()
                    })
                )
                if (category[category[parent_id][i]['id']] != undefined){
                    var n = Build(root, category, category[parent_id][i]['id'])
                    var sliger = $('<div/>',{
                        class: 'button visible'
                    }).click({state: 0, node: n},
                        function(e){
                            if(e.data.state == 1){
                                $(this).removeClass('hidden').addClass('visible')
                                e.data.node.slideDown()
                                e.data.state = 0
                            } else {
                                $(this).removeClass('visible').addClass('hidden')
                                e.data.node.slideUp()
                                e.data.state = 1
                            }
                        })
                    $(c).prepend(sliger).append(n)
                } else {
                    var block = $('<div/>', {class: 'button'})
                    $(c).prepend(block)
                }
                $(node).append(c)
            }
            return node
        }
        return this.each(function(){
            var root = $('<ul/>')
            $(this).append(root)
            Build(root, data, 0)
        })
    }
    jQuery.fn.TreeButton = function(){
        var actions = {
            'add': function (){
                for (var i = 0; i < this.data.length; ++i){

                }
            }
        }
        var create_tree_button = function(data, options){
            options = $.extend({
                class: 'TreeAddButton',
                action: 'add'
            }, options)
            var b = $('button', {
                data: data,
                click: actions[options['action']]
            })
            return b
        }
    }
})(jQuery)

function get_params_and_show_form(){
    var args = this.getAttribute('params')
    show_update_form(args.split(','))
}

var gtable

function PrepareTree(category, table) {
    PrepareForms()
    $('#tree').Tree(category)
    gtable = table
}

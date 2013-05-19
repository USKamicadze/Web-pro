#encoding: UTF-8
require_relative 'Model'
Dir.chdir('D:\USKamicadze\DVFUUUU\IT\GitHub\Web-pro\www')
MODELS = {
    'users' => Model.new(
        'users',
        [
            Field.new('id', 'ID', 'Integer'),
            Field.new('login','Логин', 'String'),
            Field.new('password', 'Пароль', 'String'),
            Field.new('name', 'Имя', 'String')
        ],[
            ReferenceField.new('groups', 'Группы', 'Array', 'groups', 'name', 'user_groups', ['user_id', 'group_id'])
        ]),
    'goods' => Model.new('goods', [
        Field.new('id', 'ID', 'Integer'),
        Field.new('name', 'Наименование', 'String'),
        Field.new('price', 'Цена', 'Integer')
    ]),
    'groups' => Model.new(
        'groups',[
        Field.new('id', 'ID', 'Integer'),
        Field.new('name', 'Имя группы', 'String')
    ]),
    'orders' => Model.new(
        'orders',[
        Field.new('id', 'Номер заказа', 'Integer'),
        Field.new('name', 'Имя заказа', 'String')
    ],[
            ReferenceField.new('users', 'Имя пользователя', 'Refer_String', 'users', 'name','order_user', ['order_id', 'user_id']),
            ReferenceField.new('goods', 'Товары', 'Array', 'goods', 'name', 'order_goods', ['order_id', 'product_id']),
        ]
    ),
    'category' => Categories.new(
        'category', [
        Field.new('id', 'ID', 'Integer'),
        Field.new('name', 'Имя категории', 'String'),
        ReferenceField.new('parent_id', 'Родительская категория', 'Refer_String', 'category', 'name', nil, nil)
        ]
    ),
    'images' => Model.new(
        'images', [
        Field.new('id', 'ID', 'Integer'),
        Field.new('name', 'Название', 'String'),
        Field.new('fs_link', 'Изображение', 'Image')
    ]
    ),
    'advanced_goods' => Model.new(
        'advanced_goods', [
        Field.new('id', 'ID', 'Integer'),
        Field.new('link_to_image', 'Изображение', 'Image'),
        Field.new('name', 'Название', 'String'),
        Field.new('price', 'Цена', 'Integer')
    ],[
      ReferenceField.new('category', 'Категория', 'Refer_String', 'category', 'name', 'agoods_category', ['agood_id', 'category_id'])
    ]
    )

}

require_relative 'View'

VIEWS = {
  'main_template' => View.new('main_template.haml'),
  'category_template' => View.new('category_template.haml'),
  'images_template' => View.new('images_template.haml'),
  'advanced_goods_template' => View.new('advanced_goods_template.haml')
}

require_relative 'Controller'

CONTROLLERS = {
    'users' => Controller.new(MODELS['users'], VIEWS['main_template']),
    'goods' => Controller.new(MODELS['goods'], VIEWS['main_template']),
    'groups' => Controller.new(MODELS['groups'], VIEWS['main_template']),
    'orders' => Controller.new(MODELS['orders'], VIEWS['main_template']),
    'category' =>  Categories_Controller.new(MODELS['category'], VIEWS['category_template']),
    'images' => Image_Controller.new(MODELS['images'], VIEWS['images_template']),
    'advanced_goods' => Controller.new(MODELS['advanced_goods'], VIEWS['advanced_goods_template'])
}
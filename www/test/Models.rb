require_relative 'Model'
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
  'categories' => Categories.new(
      'categories', [
        Field.new('id', 'ID', 'Integer'),
        Field.new('name', 'Имя категории', 'String')
      ],[
        ReferenceField.new('parent_id', 'Родительская категория', 'Refer_String', 'categories', 'name', 'sub_categories', ['parent_id', 'child_id'])
      ]
  )

}

#MODELS['users'].select(nil)
require_relative 'Model'
MODELS = {
  'users' => Model.new(
    'users',
      [
        Field.new('id', 'ID', 'Integer'),
        Field.new('login','�����', 'String'),
        Field.new('password', '������', 'String'),
        Field.new('name', '���', 'String')
      ],[
        ReferenceField.new('groups', '������', 'Array', 'groups', 'name', 'user_groups', ['user_id', 'group_id'])
  ]),
  'goods' => Model.new('goods', [
    Field.new('id', 'ID', 'Integer'),
    Field.new('name', '������������', 'String'),
    Field.new('price', '����', 'Integer')
  ]),
  'groups' => Model.new(
      'groups',[
        Field.new('id', 'ID', 'Integer'),
        Field.new('name', '��� ������', 'String')
  ]),
  'orders' => Model.new(
      'orders',[
        Field.new('id', '����� ������', 'Integer'),
        Field.new('name', '��� ������', 'String')
      ],[
        ReferenceField.new('users', '��� ������������', 'Refer_String', 'users', 'name','order_user', ['order_id', 'user_id']),
        ReferenceField.new('goods', '������', 'Array', 'goods', 'name', 'order_goods', ['order_id', 'product_id']),
      ]
  ),
  'categories' => Categories.new(
      'categories', [
        Field.new('id', 'ID', 'Integer'),
        Field.new('name', '��� ���������', 'String')
      ],[
        ReferenceField.new('parent_id', '������������ ���������', 'Refer_String', 'categories', 'name', 'sub_categories', ['parent_id', 'child_id'])
      ]
  )

}

#MODELS['users'].select(nil)
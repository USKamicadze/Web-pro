#!C:\RailsInstaller\Ruby1.9.3\bin\ruby.exe
#encoding: windows-1251

require_relative 'View'

Views = {
    'main_template' => View.new('main_template.haml'),
    'category_template' => View.new('category_template.haml')
}
require 'mini_magick'

module Image

  def Image.create_thumb(file, new_name)
    thumbnail = MiniMagick::Image.read(file)
    thumbnail.resize("100x100")
    Dir.chdir('D:\USKamicadze\DVFUUUU\IT\GitHub\Web-pro\www\images\thumb')
    thumbnail.write(new_name)
  end

end


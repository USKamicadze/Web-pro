require 'mini_magick'

module Image

  def Image.create_thumb(file, new_name)
    thumbnail = MiniMagick::Image.read(file)
    thumbnail.resize("100x100")
    thumbnail.write('\images\thumb\\' + new_name)
  end

end


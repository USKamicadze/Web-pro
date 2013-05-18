require 'mini_magick'

def resize_and_crop(image, size)
  if image[:width] < image[:height]
    remove = ((image[:height] - image[:width])/2).round
    image.shave("0x#{remove}")
  elsif image[:width] > image[:height]
    remove = ((image[:width] - image[:height])/2).round
    image.shave("#{remove}x0")
  end
  image.resize("#{size}x#{size}")
  return image
end

module Image

  def Image.create_thumb(file, new_name)
    img = MiniMagick::Image.read(file)
    thumbnail = resize_and_crop(img, 150)
    thumbnail.write('images\thumb\\' + new_name)
  end

end


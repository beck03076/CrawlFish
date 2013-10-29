require "rmagick"

source = Magick::Image.read("/home/think/CrawlFish/public/Images/Laptop-Images/Acer/Acer-AOD-270-268ws-Laptop-NUSGESI001/Acer-AOD-270-268ws-Laptop-NUSGESI001.jpg").first
source.resize_to_fill(70, 70).write("stamp.png")

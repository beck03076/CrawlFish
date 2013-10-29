module Image

  def stamp(color)
    manipulate! format: "png" do |source|
      overlay_path = Rails.root.join("app/assets/images/stamp_overlay.png")
      overlay = Magick::Image.read(overlay_path).first
      source = source.resize_to_fill(70, 70).quantize(256, Magick::GRAYColorspace).contrast(true)
      source.composite!(overlay, 0, 0, Magick::OverCompositeOp)
      colored = Magick::Image.new(70, 70) { self.background_color = color }
      colored.composite(source.negate, 0, 0, Magick::CopyOpacityCompositeOp)
    end
  end
  
end

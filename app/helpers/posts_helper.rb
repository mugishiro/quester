module PostsHelper
  require 'mini_magick'

  BASE_IMAGE_PATH = './app/assets/images/default.png'.freeze
  GRAVITY = 'center'.freeze
  TEXT_POSITION = '0,0'.freeze
  FONT = './app/assets/fonts/font.ttf'.freeze

  class << self
    def build(text)
      text = prepare_text(text.to_s)
      @image = MiniMagick::Image.open(BASE_IMAGE_PATH)
      configuration(text)
    end

    private

    def configuration(text)
      @image.combine_options do |config|
        config.font FONT
        config.resize "500x500"
        config.gravity 'center'
        config.pointsize @font_size
        config.draw "text #{TEXT_POSITION} '#{text}'"
      end
    end

    def prepare_text(text)
      if text.length > 200
        indention_count = 25
        @font_size = 15
        row_limit = 20
      else
        indention_count = 20
        @font_size = 20
        row_limit = 10
      end
      text.scan(/.{1,#{indention_count}}/)[0..row_limit].join("\n")
    end
  end
end

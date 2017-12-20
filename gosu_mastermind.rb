  require 'gosu'

  module ZOrder
    BACKGROUND, GRID, PEGS, UI = *0..3
  end

  class Mastermind < Gosu::Window

    def initialize
      super 640, 480
      self.caption = "Mastermind"
      @background_image = Gosu::Image.new("media/grey_background.gif", :tileable => true)
      @font = Gosu::Font.new(30)
    end

    def update

    end

    def draw
      @background_image.draw(0,0,ZOrder::BACKGROUND)
      @font.draw("Mastermind", 250, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
    end

  end

  Mastermind.new.show

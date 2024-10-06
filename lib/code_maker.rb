# frozen_string_literal: true

module Mastermind
  class CodeMaker
    attr_accessor :colorize_tiny_pegs, :bool

    def initialize
      @secret_code = Array.new(4, '')
      @colorize_tiny_pegs = []
    end

    def random_code
      @secret_code = @secret_code.map do |_|
        Board::COLORS[Random.rand(7)]
      end
    end

    def check_guess(code)
      code.each_with_index do |color, idx|
        if @secret_code.include?(color)
          if @secret_code[idx] == color
            @colorize_tiny_pegs.push('red')
          else
            @colorize_tiny_pegs.push('white')
          end
        end
      end
      @colorize_tiny_pegs
    end

    def winner?(code)
      @bool = @secret_code.map.with_index do |color, index|
        color == code[index]
      end
      @bool.all?
    end

    def reset
      @colorize_tiny_pegs = []
    end
  end
end

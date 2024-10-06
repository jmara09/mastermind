# frozen_string_literal: true

module Mastermind
  class Computer
    attr_accessor :colorize_tiny_pegs, :bool

    def initialize
      @ai_code = Array.new(4, '')
    end

    def random_code
      @ai_code = @ai_code.map do |_|
        Board::COLORS[Random.rand(7)]
      end
    end

    def check_guess(code)
      @pegs = []
      @code_copy = @ai_code.dup

      code.each_with_index do |color, idx|
        if @code_copy[idx] == color
          @pegs.push('red')
          @code_copy[idx] = nil
        end
      end

      code.each_with_index do |color, idx|
        if @code_copy.include?(color) && @code_copy[idx] != color
          @pegs.push('white')
          @code_copy[@code_copy.index(color)] = nil
        end
      end

      @pegs
    end

    def winner?(code)
      @bool = @ai_code.map.with_index do |color, index|
        color == code[index]
      end
      @bool.all?
    end
  end
end

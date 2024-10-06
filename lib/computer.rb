# frozen_string_literal: true

module Mastermind
  class Computer
    attr_accessor :bool, :ai_code

    def initialize
      @ai_code = Array.new(4) { |_| Board::COLORS[Random.rand(7)] }
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

    def winner?(secret_code, guess_code)
      @bool = secret_code.map.with_index do |color, index|
        color == guess_code[index]
      end
      @bool.all?
    end
  end
end

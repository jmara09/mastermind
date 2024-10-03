# frozen_string_literal: true

module Mastermind
  class CodeBreaker
    def initialize
      @guess_code = []
    end

    def guess_the_code
      list_of_colors

      loop do
        @input = gets.chomp

        unless @input.to_i.between?(1, 7)
          puts 'Please choose between 1 to 7 only'
          redo
        end

        @guess_code << Board::COLOR[@input.to_i - 1]

        return @guess_code if @guess_code.length == 4
      end
    end

    private

    def list_of_colors
      puts <<~STRING
        Choose 4 colors and type the number on it's left side.

        1 - #{'Red'.colorize(:red)}
        2 - #{'Blue'.colorize(:blue)}
        3 - White
        4 - #{'Black'.colorize(:black)}
        5 - #{'Green'.colorize(:green)}
        6 - #{'Yellow'.colorize(:yellow)}
        7 - #{'Magenta'.colorize(:magenta)}

      STRING
    end
  end
end

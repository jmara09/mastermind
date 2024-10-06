# frozen_string_literal: true

module Mastermind
  class CodeBreaker
    attr_reader :guess_code

    def initialize
      @guess_code = []
    end

    def guess_the_code
      list_of_colors

      loop do
        @input = gets.chomp.split

        unless @input.length == 4
          puts 'Please choose only 4 colors'
          redo
        end

        @input.each do |num|
          unless num.to_i.between?(1, 7)
            puts 'Please choose betweem 1 - 7 only'
            break
          end

          @guess_code << Board::COLORS[num.to_i - 1]
        end
        return @guess_code if @guess_code.length == 4
      end
    end

    def reset
      @guess_code = []
    end

    private

    def list_of_colors
      puts <<~STRING
        Choose 4 colors and type the number on its left side.

        1 - #{'Red'.colorize(:red)}
        2 - #{'Blue'.colorize(:blue)}
        3 - #{'White'.colorize(:white)}
        4 - #{'Black'.colorize(:black)}
        5 - #{'Green'.colorize(:green)}
        6 - #{'Yellow'.colorize(:yellow)}
        7 - #{'Magenta'.colorize(:magenta)}

      STRING
      puts 'Please enter your choices separated by spaces:'
    end
  end
end

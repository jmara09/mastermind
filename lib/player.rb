# frozen_string_literal: true

module Mastermind
  class Player
    USER = %w[maker breaker].freeze

    attr_accessor :colors

    def initialize
      @colors = []
    end

    def get_code
      @colors = []

      loop do
        @input = gets.chomp.split

        unless @input.length == 4
          puts 'Please choose only 4 colors'
          redo
        end

        @input.each do |num|
          unless num.to_i.between?(1, 7)
            puts 'Please choose betweem 1 - 7 only'
            @colors = []
            break
          end

          @colors << Board::COLORS[num.to_i - 1]
        end
        return @colors if @colors.length == 4
      end
    end

    def list_of_colors
      print "\n1. #{' Red '.colorize(background: :red)} " \
            "2. #{' Blue '.colorize(background: :blue)} " \
            "3. #{' White '.colorize(background: :white, color: :black)} " \
            "4. #{' Black '.colorize(background: :black, color: :white)} " \
            "5. #{' Green '.colorize(background: :green)} " \
            "6. #{' Yellow '.colorize(background: :yellow)} " \
            "7. #{' Magenta '.colorize(background: :magenta)}\n\n"
      puts 'Please enter the number of each of your four choices, separated by a space:'
    end
  end
end

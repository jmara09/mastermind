# frozen_string_literal: true

module Mastermind
  class Player
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

    def check_computer_guess(code, your_code)
      puts "\nThe computer's guess: " \
           "#{code[0].colorize(background: code[0].to_sym)}, #{code[1].colorize(background: code[1].to_sym)}, " \
           "#{code[2].colorize(background: code[2].to_sym)}, #{code[3].colorize(background: code[3].to_sym)}\n\n" \
           'Your secret codes are: ' \
           "#{your_code[0].colorize(background: your_code[0].to_sym)}, #{your_code[1].colorize(background: your_code[1].to_sym)}, " \
           "#{your_code[2].colorize(background: your_code[2].to_sym)}, #{your_code[3].colorize(background: your_code[3].to_sym)}\n\n"

      loop do
        @color = %w[white red]
        @pegs = []

        print "Type #{' Red '.colorize(background: :red)} if it's in position. " \
              "Otherwise, type #{' White '.colorize(background: :white, color: :black)} if it's out of position: "

        @pegs = gets.chomp.downcase.split

        @boolean = @pegs.each do |color|
          unless @color.include?(color)
            puts 'Only red or white color please'
            return false
          end
        end

        redo if @boolean == false
        return @pegs
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
      print 'Please enter the number of each of your four choices, separated by a space: '
    end
  end
end

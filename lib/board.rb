# frozen_string_literal: true

module Mastermind
  class Board
    COLORS = %w[red blue white black green yellow magenta].freeze
    TINY_PEG = %w[white red].freeze

    attr_reader :checker

    def initialize
      @board_tiny_pegs = Array.new(12, Array.new(4, ' '))
      @board_guess_pegs = Array.new(12, Array.new(4, '   '))
      @checker = []
      @guess = []
      @tries = 0
    end

    def guess_pegs(code)
      @tries += 1
      @guess << code
    end

    def accumulate_checker(code)
      @checker << code
    end

    def game_board
      top_board(@board_tiny_pegs)
      bottom_board(@board_guess_pegs)
    end

    def colorize_top
      @board_tiny_pegs = @board_tiny_pegs.map.with_index do |column, i|
        next column if i > @tries - 1

        column.map.with_index do |pegs, j|
          if @checker[i][j] == 'red' || @checker[i][j] == 'white'
            pegs.colorize(background: @checker[i][j].to_sym, mode: :bold)
          else
            pegs
          end
        end
      end
    end

    def colorize_bottom
      @board_guess_pegs = @board_guess_pegs.map.with_index do |column, i|
        next column if i > @tries - 1

        column.map.with_index do |pegs, j|
          pegs.colorize(background: @guess[i][j].to_sym, mode: :bold)
        end
      end
    end

    private

    def top_board(board)
      puts "#{'+-----' * 11}+-----+"
      3.times do |i|
        12.times do |j|
          next unless (i + 1).odd?

          if j.zero?
            print "| #{board[j][i]} #{board[j][i + 1]} | "
          else
            print "#{board[j][i]} #{board[j][i + 1]} | "
          end

          puts "\n" if j == 11
        end
        puts "#{'|     ' * 12}|" if i == 1
      end
    end

    def bottom_board(board)
      puts "#{'+-----' * 11}+-----+"
      4.times do |i|
        12.times do |j|
          if j == 11
            print "| #{board[j][i]} |"
          else
            print "| #{board[j][i]} "

          end
        end
        puts "\n#{'|     ' * 12}|" if i != 3
      end
      puts "\n#{'+-----' * 11}+-----+"
    end
  end
end

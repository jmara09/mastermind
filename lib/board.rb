# frozen_string_literal: true

module Mastermind
  class Board
    COLOR = %w[red blue white black green yellow magenta].freeze
    TINY_PEG = %w[white black].freeze

    def initialize
      @secret_code = []
      @board_guess_accuracy = Array.new(12, Array.new(4, '0'))
      @board_guess_pegs = Array.new(12, Array.new(4, '0'))
      @guess = []
      @tries = 0
    end

    def guess_pegs(code)
      @tries += 1
      @guess << code
    end

    def game_board
      top_board(@board_guess_accuracy)
      bottom_board(@board_guess_pegs)
    end

    def colorize_bottom
      @board_guess_pegs = @board_guess_pegs.map.with_index do |column, i|
        column.map.with_index do |pegs, j|
          if i <= @tries - 1
            pegs.colorize(@guess[i][j].to_sym)
          else
            pegs
          end
        end
        # break if idx == @tries
      end
    end

    private

    def top_board(board)
      puts "#{'+-----' * 11}+-----+"
      4.times do |i|
        12.times do |j|
          next unless (i + 1).odd?

          if j.zero?
            print "| #{board[j][i]} #{board[j][i + 1]} | "
          else
            print "#{board[j][i]} #{board[j][i + 1]} | "
          end
          puts "\n" if j == 11
        end
      end
    end

    def bottom_board(board)
      puts "#{'+-----' * 11}+-----+"
      4.times do |i|
        12.times do |j|
          if j == 11
            print "|  #{board[j][i]}  |"
          else
            print "|  #{board[j][i]}  "
          end
        end
        puts "\n"
      end
      puts "#{'+-----' * 11}+-----+"
    end
  end
end

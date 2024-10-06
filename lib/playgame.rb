# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'computer'

class PlayGame
  include Mastermind

  TRIES = 12

  attr_accessor :ai, :player, :board, :user

  def initialize
    self.ai = Computer.new
    self.player = Player.new
    self.board = Board.new
  end

  def greetings
    puts <<~GREET

      Welcome! Would you like to be a Code Maker or Code Breaker?

      Please choose the number corresponding to your choice:

      1. Code Maker
      2. Code Breaker

    GREET

    input
  end

  def user_breaker
    puts "\nYou picked the Code Breaker. Let's get cracking and choose a combination of colors"
    TRIES.times do |index|
      player.list_of_colors
      @user_guess = player.get_code
      @red_or_white = ai.check_guess(@user_guess)
      board.accumulate_checker(@red_or_white)
      board.guess_pegs(@user_guess)
      board.colorize_top
      board.colorize_bottom
      puts board.game_board
      break puts 'Congratulations! Yer a hacker, mate' if ai.winner?(ai.ai_code, @user_guess)

      puts "You're out of tries. Better luck next time!" if index == 11
    end
  end

  def user_maker
    puts "\nYou picked the Code Maker. Now, create a combination of colors for your secret code"
    player.list_of_colors
    @mystery_code = player.get_code
    TRIES.times do |index|
      @ai_guess = Array.new(4) { |_| Board::COLORS[Random.rand(7)] }
      board.accumulate_checker(player.check_computer_guess(@ai_guess, @mystery_code))
      board.guess_pegs(@ai_guess)
      board.colorize_top
      board.colorize_bottom
      puts board.game_board
      break puts "You lose! We can't compete against our AI overlords" if ai.winner?(@mystery_code, @ai_guess)

      puts 'Your secret code is safe.' if index == 11
    end
  end

  def input
    loop do
      @user = gets.chomp.to_i

      unless @user.between?(1, 2)
        puts 'Please choose again between the 1 and 2'
        redo
      end

      @user = @user == 1 ? 'maker' : 'breaker'

      break
    end
  end
end

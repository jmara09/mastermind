# frozen_string_literal: true

require_relative 'lib/playgame'

require 'colorize'

mastermind = PlayGame.new

mastermind.greetings

if mastermind.user == 1
  mastermind.user_maker
else
  mastermind.user_breaker
end

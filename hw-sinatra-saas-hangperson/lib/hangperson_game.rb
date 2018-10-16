# frozen_string_literal: true


# Our Web-based version of the popular game "hangman" works as follows:
#   1. The computer picks a random word.
#   2. The player guesses letters in order to guess the word.
#   3. If the player guesses the word before making seven wrong guesses of
#      letters, they win; otherwise they lose. Guessing the same letter
#      repeatedly is simply ignored.
#   4. A letter that has already been guessed or is a non-alphabet character
#      is considered "invalid", i.e. it is not a "valid" guess.
class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError if letter == ''
    raise ArgumentError if letter !~ /[[:alpha:]]/
    raise ArgumentError if letter.nil?

    different = !(@guesses.include? letter) && !(@wrong_guesses.include? letter)
    lower_case = letter >= 'a' && letter <= 'z'
    valid = different && lower_case
    return false unless valid
    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    valid
  end

  def word_with_guesses
    guessed = '-' * @word.length
    @word.each_char.with_index do |letter, index|
      guessed[index] = letter if @guesses.include? letter
    end
    guessed
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length > 6
    return :win unless word_with_guesses.include? '-'
    :play
  end

  def self.random_word
    require 'uri'
    require 'net/http'

    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start do |http|
      return http.post(uri, '').body
    end
  end
end

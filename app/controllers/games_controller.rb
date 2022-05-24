require 'open-uri'
require 'json'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
    if session[:word_game] != 0
      @score = session[:word_game]
    else
      session[:word_game] = 0
      @score = session[:word_game]
    end
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || '').upcase
    @included = included?(@word, @letters)
    @english = english?(@word)
  end

  #   if included?
  #     if english?
  #       @message = "Congratulations! #{params[:word].upcase} is a valid English word!"
  #       session[:word_game] += params[:word].chars.count
  #       @score = session[:word_game]
  #     else
  #       @message = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
  #       session[:word_game] += 0
  #       @score = session[:word_game]
  #     end
  #   else
  #     @message = "Sorry but #{params[:word].upcase} can't be built out of #{params[:grid].split(" ").join(", ")}"
  #     session[:word_game] += 0
  #     @score = session[:word_game]
  #   end
  # end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end

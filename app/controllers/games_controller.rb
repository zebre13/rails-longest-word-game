require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = Array.new(10) { ('A'..'Z').to_a.sample }
    if session[:word_game] != 0
      @score = session[:word_game]
    else
      session[:word_game] = 0
      @score = session[:word_game]
    end
  end

  def score
    if included?
      if english?
        @message = "Congratulations! #{params[:word].upcase} is a valid English word!"
        session[:word_game] += params[:word].chars.count
        @score = session[:word_game]
      else
        @message = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
        session[:word_game] += 0
        @score = session[:word_game]
      end
    else
      @message = "Sorry but #{params[:word].upcase} can't be built out of #{params[:grid].split(" ").join(", ")}"
      session[:word_game] += 0
      @score = session[:word_game]
    end
  end

  def included?
    params[:word].upcase.chars.all? { |letter| params[:word].upcase.count(letter) <= params[:grid].count(letter) }
  end

  def english?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word].upcase}")
    json = JSON.parse(response.read)
    json['found']
  end
end

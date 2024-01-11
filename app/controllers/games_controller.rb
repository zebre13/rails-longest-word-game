require "open-uri"

class GamesController < ApplicationController

  def new
    alphabet = ("A".."Z").to_a
    @letters = alphabet.sample(10)
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @included = included?(@word, @letters)
    @english = english?(@word)
    @score = @included && @english ? get_score(@word) : 0
    session[:score] += @score
    @total_score = session[:score]
  end

  private

  def included?(word, letters)
    word.chars.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    response = URI.open(url)
    json = JSON.parse(response.read)
    json["found"]
  end

  def get_score(word)
    word.chars.count
  end
end

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
end

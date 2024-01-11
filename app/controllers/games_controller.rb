class GamesController < ApplicationController

  def new
    alphabet = ("A".."Z").to_a
    @grid = alphabet.sample(10)
  end

  def score
    @word = params[:word].upcase
    @grid = params[:grid].upcase
    @included = included?(@word, @grid)
    @english = english?(@word)
  end

  private

  def included?(word, grid)
    word.chars.all? do |letter|
      word.count(letter) <= grid.split(", ").count(letter)
    end
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    response = URI.open(url)
    json = JSON.parse(response.read)
    json["found"]
    # url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    # response = RestClient.get url
    # result = JSON.parse(response)
    # return result["found"]
  end
end

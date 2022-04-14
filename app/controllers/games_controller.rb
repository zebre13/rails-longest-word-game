class GamesController < ApplicationController
  def new
    @grid = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  # def score
  #   raise
  # end

  def score
    if included?
      if english?
        "Congratulations! #{params[:word].upcase} is a valid English word!"
      else
        "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
      end
    else
      "Sorry but #{params[:word].upcase} can't be built out of #{@grid.join(", ")}"
    end
  end

  def included?
    params[:word].chars.all? { |letter| params[:word].count(letter) <= @grid.count(letter) }
  end

  def english?
    require 'open-uri'
    require 'json'
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    json[:found]
  end
end

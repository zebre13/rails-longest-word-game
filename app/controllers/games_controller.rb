class GamesController < ApplicationController

  def new
    alphabet = ("A".."Z").to_a
    @grid = alphabet.sample(10)
  end

  def score
    @word = params[:word]
    @grid = params[:grid]


    # if from_grid?(@word)
    #   @message = "Sorry but #{@word.upcase} can't be built out of #{@grid}"
    # els
    if english?(@word)
      @message = "Sorry but #{@word.upcase} doesn't seem to be a valid English word!"
    else
      @message = "Congratulations! #{@word.upcase} is a valid English word!"
    end
  end

  private

  def from_grid?(word)

  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    response = RestClient.get url
    result = JSON.parse(response)
    return result["found"]
  end
end

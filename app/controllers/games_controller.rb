class GamesController < ApplicationController
  def new
    alphabet = ("A".."Z").to_a
    @grid = alphabet.sample(10)
  end

  def score
    @word = params[:word]
  end
end

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << alphabet.sample }
  end

  def score
    @message = nil
    @word = params[:word]
    rest = @letters - @word.split
    if rest.length == 10 - @word.split.length
      @message = "Congratulations! #{@word.upcase} is a valid English word!"
    elsif rest.length == 11 - @word.split.length
      @message = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    else
      @message = "Sorry but #{@word.upcase} can't be built out of #{@letters.join(", ")}"
    end
  end
end

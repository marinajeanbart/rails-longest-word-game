require  "open-uri"

class GamesController < ApplicationController
  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @total = 0
    @letters = params[:letters].split(" ")
    @word = params[:word].split("")
    counter = 0
    @word.each do |letter|
      if @letters.include? letter
        counter += 1
      end
    end
    if @word.length == counter
      if english_word?(params[:word])
        @total += 1
        @result = [@score, "well done"]
      else
        @result = "not an english word"
      end
    else
      @result = "not in the grid"
    end
  end
end

require 'open-uri'
require 'json'

class GamesController < ApplicationController
  protect_from_forgery
  def new
    @letters = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z].sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:grid].split(' ')
    @eh = @word.upcase.split(//)
    @message = check(@eh, @letters)
  end

  private

  def check(word, grid)
    @words = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{word.join('').downcase}").read)
    if word.all? { |letter| grid.include?(letter) && (word.count(letter) <= grid.count(letter)) }
      if @words['found'] == true
        "Congratulations! #{word.join('')} is an English word!"
      else
        "Sorry but #{word.join('')} does not seem to be a valid English word..."
      end
    else
      "Sorry but #{word.join('')} can't be built out of #{grid.join(', ')}"
    end
  end
end

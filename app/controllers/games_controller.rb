require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(4) { VOWELS.sample }
    @letters += Array.new(6) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end

# class GamesController < ApplicationController
#   def new
#     @letters = Array.new(10) { ('A'..'Z').to_a.sample }
#   end

#   def score
#     @answer = ''
#     if @answer == (params[:answer])
#       if english_word?(params[:answer])
#         @answer = "well done, #{params[:answer]} is a word"
#       else
#         @answer = "not an english word"
#       end
#     else
#       @answer = "sorry, can't do that!"
#     end
#   end

  # def score_and_message
  #   if included?(params[:answer])
  #     if english_word?(params[:answer])
  #       "well done, #{params[:answer]} is a word"
  #     else
  #       "not an english word"
  #     end
  #   else
  #     "not in the grid"
  #   end
  # end

  # def english_word?(params[:answer])
  #   response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:answer]}")
  #   json = JSON.parse(response.read)
  #   return json['found']
  # end
# end

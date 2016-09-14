class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    if (/\p{L}/ =~ letter) != 0
      raise ArgumentError
    end
    letter = letter.downcase
    if @guesses.include?(letter) or @wrong_guesses.include?(letter)
      return false
    end
    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    return true
  end
  
  def word_with_guesses
    display = ''
    @word.each_char do |c|
      if @guesses.include?(c)
        display += c
      else
        display += '-'
      end
    end
    return display
  end
  
  def check_win_or_lose
    if self.word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end
end

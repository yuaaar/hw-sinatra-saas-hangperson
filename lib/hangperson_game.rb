class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(char)
    if !(char =~ /^[[:alpha:]]$/)
      raise ArgumentError
    end
    char = char.downcase
    if (@guesses+@wrong_guesses).include?(char)
      return false
    elsif @word.include?(char)
      @guesses += char
    elsif !@word.include?(char)
      @wrong_guesses += char
    end
    return true
  end
  
  def word_with_guesses
    @word.gsub(/[^#{'#'+@guesses}]/, '-')
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    elsif word_with_guesses.include?('-')
      return :play
    else
      return :win
    end
  end

end

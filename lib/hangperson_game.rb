class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  def initialize(word)
    @word = word.downcase
    @guesses = ""
    @wrong_guesses = ""
    @word_with_guesses =""
    
  end

  def guess(letter)
   raise ArgumentError if not letter =~ /^[a-zA-z]$/
    
    letter.downcase!
    return false if guesses.include? letter
    return false if wrong_guesses.include? letter
    if word.include? letter and not guesses.include? letter
      guesses<< letter 
      return true
     else
      wrong_guesses << letter
      return true
    end
  end
  def word_with_guesses
    if guesses.empty? 
     '-' * word.length 
    else
      word.gsub(/[^#{guesses}]/, '-')
    end
  end
  
  def check_win_or_lose
    return :lose if wrong_guesses.length == 7
    return :win if word =~ /[^#{guesses}]/
    :play
  end
  
  def word()
    @word 
  end

  def wrong_guesses()
    @wrong_guesses
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
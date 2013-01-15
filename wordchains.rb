class Chain
  attr_accessor :start_word, :end_word

  def initialize(start_word, end_word)
    @start_word = start_word
    @end_word = end_word
    @dictionary = []
  end

  def load_dictionary
    File.foreach("2of12inf.txt") do |line|
      @dictionary << line.chomp.chomp("%").downcase
    end
  end
  def possible_words
    possible_words = []
    @dictionary.each do |word|
      possible_words << word if word.length == @start_word.length
    end
  end

end

game = Chain.new("hard", "cart")
game.load_dictionary
game.possible_words
class Chain
  attr_accessor :start_word, :end_word, :dictionary, :possible_words

  def initialize(start_word, end_word)
    @start_word = start_word
    @end_word = end_word
    @dictionary = []
    @possible_words = []
  end

  def load_dictionary
    File.foreach("2of12inf.txt") do |line|
      @dictionary << line.chomp.chomp("%").downcase
    end
  end

  def initialize_possible_words
    @possible_words = []
    @dictionary.each do |word|
      @possible_words << word if word.length == @start_word.length
    end
    @possible_words -= [@start_word]
  end

  def remove_adjacent_words(adjacent_words)
    @possible_words -= adjacent_words
  end

  def adjacent_words(parent_word)
    adjacent_words = []
    (0..parent_word.length-1).each do |index|
      ("a".."z").each do |letter|
        new_word = parent_word.dup
        new_word[index] = letter

        if @possible_words.include?(new_word) && new_word != parent_word
          adjacent_words << new_word
        end
      end
    end
    adjacent_words
  end

  def wordchains
    load_dictionary
    initialize_possible_words

    a = adjacent_words("duck")
    remove_adjacent_words(a)

    adjacent_words
  end

end





game = Chain.new("duck", "ruby")
game.wordchains

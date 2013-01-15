# Vincent Chang & Jason Wong
# January 14, 2013

class Chain

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

    path = find_path

    print_path(path)

  end

  def find_path

    all_adjacent_words = {@start_word => nil}
    new_words = [@start_word]
    new_adjacent_words = []

    until all_adjacent_words.has_key?(@end_word) || new_words.empty?    #if new_words is empty that means there is no path between start_word and end_word
      parent_words = new_words.dup

      parent_words.each do |parent_word|
        child_words = adjacent_words(parent_word)
        remove_adjacent_words(child_words)

        child_words.each do |child_word|
          all_adjacent_words[child_word] = parent_word
        end

        new_words += child_words
      end

      new_words -= parent_words
    end

    if new_words.empty?
      path = []
    else
      parent = all_adjacent_words[@end_word]
      path = [@end_word]

      until parent.nil?
        path << parent
        parent = all_adjacent_words[parent]
      end
    end

    path
  end

  def print_path(path)
    if path.empty?
      puts "Sorry, there is no path from #{@start_word} to #{@end_word}"
    else
      p path.reverse.join(", ")
    end
  end

end

#Scripts------------------------------------------------------------------------

game = Chain.new("duck", "ruby")
#game = Chain.new("happy", "crazy")
#game = Chain.new("orange", "purple")
game.wordchains
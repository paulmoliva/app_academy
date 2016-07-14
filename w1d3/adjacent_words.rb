require 'set'

class WordChainer
  attr_reader :dictionary
  def initialize(dictionary_file_name)
   @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
   @dictionary = Set.new(@dictionary)
 end

  def adjacent_words(word)
    #@dictionary.select { |w| one_off?(w, word) && w.length == word.length }
    # variable name *masks* (hides) method name; references inside
    # `adjacent_words` to `adjacent_words` will refer to the variable,
    # not the method. This is common, because side-effect free methods
    # are often named after what they return.
    adjacent_words = []

    # NB: I gained a big speedup by checking to see if small
    # modifications to the word were in the dictionary, vs checking
    # every word in the dictionary to see if it was "one away" from
    # the word. Can you think about why?
    word.each_char.with_index do |old_letter, i|
      ('a'..'z').each do |new_letter|
        # Otherwise we'll include the original word in the adjacent
        # word array
        next if old_letter == new_letter

        new_word = word.dup
        new_word[i] = new_letter

        adjacent_words << new_word if dictionary.include?(new_word)
      end
    end

    adjacent_words
  end

  def one_off?(word1, word2)
    count = 0
    word1.chars.each_with_index do |char, i|
      count += 1 unless char == word2[i]
      return false if count > 1
    end
    count == 1
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}
    until @current_words.empty?
      @new_current_words = explore_current_words(@current_words, target)
      @current_words = @new_current_words
    end
    path = build_path(target)
    path.reverse.each{|el| puts el}
  end

  def explore_current_words(current_words, target)
    @new_current_words = []
    @current_words.each do |current_word|
      adjacents = adjacent_words(current_word)
      adjacents.each do |adjacent_word|
        unless @all_seen_words.has_key?(adjacent_word)
          @new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
          #return [target] if adjacent_word == target
        end
      end
    end
    return @new_current_words
  end

  def build_path(target)
    return [target] if @all_seen_words[target] == nil
    source = @all_seen_words[target]
    # p source
    path = []
    path += [target] + [build_path(source)]
    path.flatten
  end

end
chainer = WordChainer.new('dictionary.txt')
chainer.run('bear', 'ruby')

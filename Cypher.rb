class Cypher
  def initialize(sentence, shift)
    @sentence = sentence
    @shift = shift
  end

  def encrypt
    words = @sentence.split("")
    cypher = words.map do |word|
      if lowercase?(word) || uppercase?(word)
        wrap(word)
      else
       word
      end
    end
    cypher.join("")
  end

  private
  def uppercase?(word)
    word =~ /[A-Z]/
  end

  def lowercase?(word)
    word =~ /[a-z]/
  end

  def wrap(word)
    if lowercase?(word) && word.ord + @shift > 122
      shifted = word.ord + @shift - 26
      shifted.chr
    elsif uppercase?(word) && word.ord + @shift > 90
      shifted = word.ord + @shift - 26
      shifted.chr
    else
      shifted = word.ord + @shift
      shifted.chr
    end
  end
end

cypher = Cypher.new("What a string!", 5)
puts cypher.encrypt


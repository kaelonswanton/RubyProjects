def substrings(sentence, dictionary)
  hash = {}
  lower_sentence = sentence.downcase
  dictionary.each do |word|
    hash[word] = lower_sentence.scan(word).length if lower_sentence.include?(word)
  end
  hash
end
dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)

str = File.read('madlibs_text.txt')
word_arr = str.split(' ')

print "Give me a noun: "
noun = gets.chomp

print "Give me an adjective: "
adjective = gets.chomp

print "Give me a verb: "
verb = gets.chomp

print "Give me an adverb: "
adverb = gets.chomp

str.gsub!(/%{noun}/, noun)
str.gsub!(/%{adjective}/, adjective)
str.gsub!(/%{verb}/, verb)
str.gsub!(/%{adverb}/, adverb)

# puts ""
# puts str

ADJECTIVES = %w(quick lazy sleepy ugly).freeze
NOUNS      = %w(fox dog head leg cat tail).freeze
VERBS      = %w(spins bites licks hurdles).freeze
ADVERBS    = %w(easily lazily noisly excitedly).freeze

File.open('madlibs_text.txt') do |file|
  file.each do |line|
    puts format(line, noun:      NOUNS.sample,
                      verb:      VERBS.sample,
                      adjective: ADJECTIVES.sample,
                      adverb:    ADVERBS.sample)
  end
end

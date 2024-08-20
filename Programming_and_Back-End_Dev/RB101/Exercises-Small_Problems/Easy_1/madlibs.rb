def prompt(text)
  loop do
    print "Enter a #{text}: "
    return gets.chomp
  end
end

def madlibs
  noun = prompt("noun")
  verb = prompt("verb")
  adj = prompt("adjective")
  adv = prompt("adverb")

  stories = [
    "Do you #{verb} your #{adj} #{noun} #{adv}? That's hilarious!",
    "The #{adj} #{noun} #{adv} #{verb}.",
    "The #{adj} #{noun} #{verb} #{adv}."
  ]
  puts stories.sample
end
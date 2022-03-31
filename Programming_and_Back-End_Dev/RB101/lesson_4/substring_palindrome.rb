# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []

def palindrome_substrings(str)
  arr = []
  c = 2
  while c <= str.size
    i = 0
    while i < (str.size - c + 1)
      if str[i, c] == str[i, c].reverse
        arr << str[i, c]
      end
      i += 1
    end
    c += 1
  end
  arr
end

p palindrome_substrings("supercalifragilisticexpialidocious")
p palindrome_substrings("abcddcbA")
p palindrome_substrings("palindrome")
p palindrome_substrings("")

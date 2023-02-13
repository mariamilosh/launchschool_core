# Better to use StandardError than Exception to handle application-level
# errors rather than Exception
class AuthenticationError < StandardError; end


# A mock search engine
# that returns a random number instead of an actual count.
class SearchEngine
  def self.count(query, api_key)
    # p valid?(api_key)
    unless valid?(api_key)
      raise AuthenticationError, 'API key is not valid.'
    end

    rand(200_000)
  end

  # private
  protected
  def self.valid?(key)
    key == 'LS1A'
  end
end

module DoesItRock
  API_KEY = 'LS1A'
  # API_KEY = 'LA'
  class NoScore; end

  #
  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f
      positive / (positive + negative)

    # rescue Exception
    #   unless SearchEngine.valid?(API_KEY)
    #     raise AuthenticationError, 'API key is not valid.'
    #   end
    #   NoScore
    # end

    rescue ZeroDivisionError
      # Needs to return instance of class so that case in #find_out
      # isn't checking if score is part of NoScore class and instead
      # checks for a value of NoScore
      NoScore.new
    end
  end

  def self.find_out(term)
    score = Score.for_term(term)
    # p score
    case score
    when NoScore
      "No idea about #{term}..."
    when 0...0.5
      "#{term} is not fun."
    when 0.5
      "#{term} seems to be ok..."
    else
      "#{term} rocks!"
    end
  rescue Exception => e
    e.message
  end
end

# Example (your output may differ)

puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
puts DoesItRock.find_out('Rain')        # Rain is not fun.
puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!

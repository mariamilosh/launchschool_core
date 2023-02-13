class Book
  attr_reader :title, :author
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# The class definition had no accessor methods so it did not know what title
# and author meant in the to_s method and also in the method calls for
# book.title and book.author

# Further Exploration
# It would not have changed anything to define the methods without attr_reader
# since that is a valid way to define an accessor method
# It could be advantageous if any changes were needed to an instance variable
# before sharing it

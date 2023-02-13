class Banner
  def initialize(message, *banner_width)
    @message = message
    if banner_width[0]
      @banner_width = banner_width[0] + 2
      @message_width = @banner_width - 2

    elsif banner_width[0] > @message.size + 2
      @message_width = banner_width[0] - 2
    else
      @banner_width = @message.size + 2
      @message_width = @banner_width - 2

    end
    # @message_width = @banner_width - 2
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+" + "-" * @banner_width + "+"
  end

  def empty_line
    "|" + " " * @banner_width + "|"
  end
# | + " "*((@banner_width-@message_width)/2) + @message.slice(0, @message_width) + " "*((@banner_width-@message_width)/2) + |
  def message_line
    # "| #{@message.slice(0, @message_width)}#{" "*(@banner_width - @message_width)} |"
    '|' + " "*((@banner_width + 2)/2) + @message.slice(0, @message_width) + " "*((@banner_width-@message_width)/2) + '|'
  end
end
# max width is @banner_width
# min width is 2
# width is @message_width + 2
#

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('')
puts banner

banner2 = Banner.new('To boldly go where no one has gone before.', 6)
puts banner2

banner3 = Banner.new('To boldly go where no one has gone before.', 70)
puts banner3

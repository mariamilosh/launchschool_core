# def print_in_box(text)
#     print_border_row(text)
#     print_inner_row(" " * text.length)
#     print_inner_row(text)
#     print_inner_row(" " * text.length)
#     print_border_row(text)
# end

# def print_border_row(text)
#     print '+'
#     (1..(text.length+2)).each { print '-' }
#     puts '+'
# end

# def print_inner_row(text)
#     puts "| #{text} |"
# end

def print_in_box(text)
    box_rows = [
        "+#{'-' * (text.length + 2)}+", 
        "|#{' ' * (text.length + 2)}|",
        "| #{text} |",
        "|#{' ' * (text.length + 2)}|",
        "+#{'-' * (text.length + 2)}+"
    ]
    box_rows.each { |row| puts row }
end

def print_in_wrapping_box(text)
    max_text_width = 76  # 80 - 4
    line_reps = (text.length / max_text_width).ceil
    text_rows = (0..line_reps).map do |row|
        text_segment = text.slice(row * max_text_width, max_text_width)
        filler = ' ' * (76 - text_segment.length)
        "| #{text_segment + (filler if text.length > 76)} |"
    end
    col_count = if text.length <= max_text_width
                    text.length
                else
                    max_text_width
                end
    box_rows = [
        "+#{'-' * (col_count + 2)}+",
        "|#{' ' * (col_count + 2)}|",
        "|#{' ' * (col_count + 2)}|",
        "+#{'-' * (col_count + 2)}+"
    ]
    box_rows.insert(2, text_rows).each { |row| puts row }
end

# print_in_box("To boldly go where no one has gone before.")
# print_in_box("**********************")
# print_in_box("Text text text text")

print_in_wrapping_box("Negative indices count backwards from the end of the array, where -1 is the last element. If a negative index is used, the given values will be inserted after that element, so using an index of -1 will insert the values at the end of the array.")
hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}
# [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]
hsh2 = Array.new
hsh.each do |key, val|
  if val[:type] =='fruit'
    hsh2 << val[:colors].map {|color| color.capitalize}
  elsif val[:type] =='vegetable'
    hsh2 << val[:size].upcase
  end
end
p hsh2

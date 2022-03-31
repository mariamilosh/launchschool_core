def select_fruit(produce)
  fruits = Hash.new
  produce.each do |k, v|
    fruits[k] = v if v == 'Fruit' 
  end
  fruits
end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}

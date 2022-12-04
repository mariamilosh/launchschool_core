def bubble_sort!(array)
  loop do
    swapped = false
    (0..array.length-2).each do |i|
      if array[i] > array[i + 1]
        tmp_val = array[i]
        array[i] = array[i + 1]
        array[i + 1] = tmp_val
        swapped = true
      end
    end
    break if !swapped
  end
end

array = [5, 3]
bubble_sort!(array)
puts array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
puts array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
puts array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)

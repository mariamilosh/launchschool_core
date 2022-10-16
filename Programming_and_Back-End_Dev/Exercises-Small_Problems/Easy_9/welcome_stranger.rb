def greetings(name_arr, job_hsh)
  "Hello, #{name_arr[0] + ' ' + name_arr[1] + ' ' + name_arr[2]}! Nice to " \
    "have a #{job_hsh[:title]} #{job_hsh[:occupation]} around."
end

puts greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })
# => Hello, John Q Doe! Nice to have a Master Plumber around.

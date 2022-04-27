hash = { a: 'ant', b: 'bear' }
hash.shift

# returns [ :a, "ant" ] because shift removes the first index key and value and
# returns it as an array

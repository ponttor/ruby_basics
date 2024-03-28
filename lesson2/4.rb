counter = 0
vowels = ['a', 'e', 'i', 'o', 'u', 'y']

result = ('a'..'z').each_with_object({}).with_index(1) do |(letter, hash), index|
  hash[letter] = index if vowels.include?(letter)
end

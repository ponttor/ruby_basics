module Helper
  class << self
    def select_from_collection(collection, prompt)
      puts prompt
      collection.each_with_index do |item, index|
        item_description = yield(item)
        puts "#{index + 1}. #{item_description}"
      end
      index = gets.to_i - 1
      collection[index]
    end
  end
end
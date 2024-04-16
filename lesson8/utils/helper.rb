# frozen_string_literal: true

require_relative '../locales/translations'

module Helper
  class << self
    def select_from_collection(collection, prompt)
      puts prompt
      collection.each_with_index do |item, index|
        item_description = yield(item)
        puts "#{index + 1}. #{item_description}"
      end
      index = gets.to_i
      raise Translations::HELPER[:errors][:not_found] if index > collection.length || index <= 0

      collection[index - 1]
    end
  end
end

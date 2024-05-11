require 'json'

class Inventory
    attr_accessor :items
    def initialize
        @items = []
        restore
        sort_items
    end

    def add(item)
        index = @items.bsearch_index { |existing_item| existing_item[:isbn] >= item[:isbn] } || @items.length
        if @items[index] && @items[index][:isbn] == item[:isbn]
          @items[index][:count] += item.count
        else
          @items.insert(index, item)
        end
      end


    def remove(isbn)
        for i in 0...@items.length
            if @items[i][:isbn] == isbn
                @items.delete_at(i)
                break
            end
        end
    end

    def list
        @items.each do |item|
            puts item
        end
    end

    def search_isbn(isbn)
        index = @items.bsearch_index { |item| item[:isbn] == isbn }
        if index
          puts @items[index]
        else
          puts "Item not found."
        end
      end

    def search_title(title)
        @items.each do |item|
            if item[:title] == title
                puts item
            end
        end
    end

    def search_author(author)
        @items.each do |item|
            if item[:author] == author
                puts item
            end
        end
    end

    def self.store(items)
        File.open("inventory.txt", "w") do |file|
            items.each do |item|
            file.puts item.to_json
          end
        end
    end

    def restore
        File.open("inventory.txt", "r") do |file|
            file.each_line do |line|
                @items.push(JSON.parse(line,symbolize_names: true))
            end
        end
    end

    def sort_items
        @items.sort_by! { |item| item[:isbn].to_i }
    end

end

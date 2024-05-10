require_relative 'Inventory'

inventory=Inventory.new

END{
    Inventory.store(inventory.items)
}

def display_menu
    puts "Welcome to the Inventory Management System"
    puts "1- List books"
    puts "2- Add new book"
    puts "3- Remove book by ISBN"
    puts "4- Search by title"
    puts "5- Search by ISBN"
    puts "6- Search by author"
    puts "0- Exit"
  end

  inventory = Inventory.new

  loop do
    display_menu
    print "Please enter your choice: "
    choice = gets.chomp.to_i

    case choice
    when 1
      puts "Listing books:"
      inventory.list
    when 2
      puts "Adding a new book:"
      print "Enter ISBN: "
      isbn = gets.chomp
      print "Enter title: "
      title = gets.chomp
      print "Enter author: "
      author = gets.chomp
      print "Enter count: "
      count = gets.chomp.to_i
      inventory.add({ isbn: isbn, title: title, author: author, count: count })
    when 3
      puts "Removing a book by ISBN:"
      print "Enter ISBN: "
      isbn = gets.chomp
      inventory.remove(isbn)
    when 4
      puts "Searching by title:"
      print "Enter title: "
      title = gets.chomp
      inventory.search_title(title)
    when 5
      puts "Searching by ISBN:"
      print "Enter ISBN: "
      isbn = gets.chomp
      inventory.search_isbn(isbn)
    when 6
      puts "Searching by author:"
      print "Enter author: "
      author = gets.chomp
      inventory.search_author(author)
    when 0
      puts "Exiting..."
      break
    else
      puts "Invalid choice. Please try again."
    end
  end

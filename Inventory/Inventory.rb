require 'csv'

class Book

  attr_accessor :title
  attr_accessor :author
  attr_accessor :isbn

def initialize(title, author, isbn)
  @title = title
  @author = author
  @isbn = isbn
end

end

class Inventory

  @@books = []

  def initialize
    books_table = CSV.parse(File.read("books.csv"), headers: true)
    books_table.each do |book|
      @@books << Book.new(book['title'],  book['author'],  book['isbn'])
    end
  end

  def list_books()
    @@books.each do |book|
      puts "ISBN: #{book.isbn}, title: #{book.title}, Author: #{book.author}"
    end
  end

  def add_book(book)
    books = []
    CSV.foreach("books.csv") do |row|
      books << row
      puts row
    end
    @@books << book
  end

  def remove_book_by_isbn(isbn)
    @@books.each_with_index do |book, index|
      if book.isbn == isbn
        @@books.delete_at(index)
      end
    end
  end

  def search_book(val, choice)
    @@books.each_with_index do |book, index|
      if book.isbn == val
        return book
      end
    end
  end
end

inventory = Inventory.new

# puts inventory.search_book(1, 2)

def show_menu(inventory)
  puts "Select Option: "
  puts "1- List books"
  puts "2- Add new book "
  puts "3- Remove Book by ISBN"
  puts "Press any key to exit"

  option = gets
  show_menu = true

  if option.to_i == 1
    inventory.list_books
  elsif option.to_i == 2
    puts "Enter ISBN"
    book_isbn = gets
    puts "Enter Title"
    book_title = gets
    puts "Enter author"
    book_author = gets
    inventory.add_book(Book.new book_title, book_author, book_isbn)
  elsif option.to_i == 3
    puts "Enter ISBN of book to delete"
    isbn = gets
    inventory.remove_book_by_isbn(isbn)
  else
    show_menu = false
  end
  puts "------------------------"
  if show_menu
    show_menu(inventory)
  end
end

show_menu(inventory)







# inventory.list_books
# puts "----------------"
# inventory.add_book(Book.new 'php', 'Dabbous', 14)
# inventory.list_books
# puts "----------------"
# inventory.remove_book_by_isbn(14)
# inventory.list_books
# puts "----------------"

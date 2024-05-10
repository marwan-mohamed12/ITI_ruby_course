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

  def initialize(file_name = "books.csv")
    @file_name = file_name
    @books = []
  end

  def load_books
    books_table = CSV.parse(File.read("books.csv"), headers: true)
    books_table.each do |row|
      @books << Book.new(row['title'], row['author'], row['isbn']) 
    end
  end

  def list_books()
    @books = []
    load_books() 
    @books.each do |book|
      puts "ISBN: #{book.isbn}, title: #{book.title}, Author: #{book.author}" 
    end
  end

  def save_to_csv
    CSV.open(@file_name, "w", quote_char: "") do |csv|
      csv << ['title', 'author', 'isbn']
      @books.each do |book|
        isbn = book.isbn.gsub("\n", "")
        title = book.title.gsub("\n", "")
        author = book.author.gsub("\n", "")
        csv << [title, author, isbn]
      end
    end
  end

  def add_book(book)
    @books << book 
    save_to_csv
  end

  def remove_book_by_isbn(isbn)
    load_books() 
    # p @books
    book_index = @books.find_index { |b| b.isbn.to_i == isbn.to_i }

    if book_index
      @books.delete_at(book_index)
      save_to_csv
      puts "Book with ISBN #{isbn} deleted."
      load_books() 
    else
      puts "Book with ISBN #{isbn} not found."
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

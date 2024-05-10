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

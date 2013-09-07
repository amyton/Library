

class User
  attr_accessor :checked_out_books

  def initialize(name)
    @name = name
    @checked_out_books = []
  end
end

class Book
  attr_accessor :status
  attr_reader :title, :author, :description

  def initialize(title, author, description)
    @title = title
    @author = author
    @description = description
    @status = "available"
  end
end

class Library
  def initialize
    @books = []
  end

  def add_book(book)
    @books << book
  end

  # Users should be able to check a book's status 
  # (e.g. available, checked out, overdue or lost)

  def book_status
    @books.each do |book|
      puts "#{book.title}, #{book.status}"
    end
  end

  # Check out available books in the library
  # user, book - the string to be added.
  # e.g. check_out("amy", "hamlet") => 
  # Returns the array with the new user + book added to the end

  def check_out(user, book)
    if book.status == "available"
      user.checked_out_books << book
      book.status = "checked out"
      puts "You checked out #{book.title}."
    else
      puts "Sorry, that book is unavailable right now."
    end
  end

  def check_in(user, book)
    # 
  end

  def overdue_books
    puts "#{@title}, checked by #{@name}" if @status == "overdue"
  end

  def checked_out_books
    puts "#{@title}" if @status == "checked out"
  end
end 

library = Library.new
amy = User.new("amy")

derp = Book.new("derp", "k", "na")
herp = Book.new("herp", "a", "k")
hamlet = Book.new("hamlet", "shake", "ya")

puts "Book 1 title: #{derp.title}"
puts "Book 2 title: #{herp.title}"
puts "Book 3 title: #{hamlet.title}"

library.add_book(derp)
library.add_book(herp)
library.add_book(hamlet)

library.book_status

library.check_out(amy, derp)

library.book_status

library.checked_out_books

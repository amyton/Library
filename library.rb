# DONE Users should be able to add books to a library 
# DONE Books should be able to have information saved about them (author, title, description)
# A user should be able to check out books from the library for one week intervals
# DONE A user should not be able to check out more than two books at any given time
# Checked-out books should be associated with a user
# Users with overdue books should not be able to request any new books until they turn all their overdue books in
# DONE Users should be able to check in books to the library when they're finished with them
# DONE Users should be able to check a book's status (e.g. available, checked out, overdue or lost)
# Users should be able to see a list of who has checked out which book and when those books are due to be returned
# Users should be able to see a list of books that are overdue



class User
  attr_accessor :checked_out_books

  def initialize(name)
    @name = name
    @checked_out_books = []
  end
end

class Book
  attr_accessor :status, :due_date
  attr_reader :title, :author, :description

  def initialize(title, author, description=nil)
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
    if book.is_a?(Book)
      @books << book
    end
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
    if book.status == "available" && user.checked_out_books.length < 2 # && OVERDUE = nil
      user.checked_out_books << book
      book.status = "checked out"
      puts "You checked out #{book.title}."
    else
      puts "Sorry, that book is unavailable right now."
    end
  end

  def check_in(user, book)
    if user.checked_out_books.include?(book)
      user.checked_out_books.delete_if { |b| b == book } 
      book.status  = "available"
      puts "Thanks for returning #{book.title}!"
    else
      puts "You don't have that book to check in."
    end
  end

  def checked_out_books
  end

  def overdue_books(book)
    puts "#{@title}, checked by #{@name}" if Book.status == "overdue"
  end

end 

library = Library.new
amy = User.new("amy")
kevin = User.new("kevin")

derp = Book.new("derp", "nyan", "cats")
herp = Book.new("herp", "finn and jake", "royal promises")
hamlet = Book.new("hamlet", "shakespeare", "everyone dies")


puts "Book 1 title: #{derp.title}"
puts "Book 2 title: #{herp.title}"
puts "Book 3 title: #{hamlet.title}"

library.add_book(derp)
library.add_book(herp)
library.add_book(hamlet)

library.book_status

library.check_out(amy, derp)

library.book_status

library.check_out(amy, derp)

library.checked_out_books

library.check_in(amy, derp)

library.check_in(amy, herp)

library.check_out(kevin, derp)

library.checked_out_books

puts "FUCK YEAH"




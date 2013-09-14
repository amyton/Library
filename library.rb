# User class contains the following information:
#
# Name - name of the User
# Rented books - Array of rented books by User
# Overdue - Overdue books 

class User
  attr_accessor :name, :rented_books

  def initialize(name)
    @name = name
    @rented_books = []
    @overdue_books = []
  end

  # Adds book to User's list of checked-out books array
  # Params:
  # 
  # Book - Title of the book
    
  def rent_book(book)
    @rented_books << book 
  end

  # Can User rent books?
  # If User's rented_books array has any over due books, or
  # if User's rented_books array contain more than two books,
  # User will be able to rent books. 
  # If not, it will return false.

  def can_rent_books?
    @rented_books.each do |b|
      if b.status == "overdue"
        return false
      end
    end
    @rented_books.count < 2
  end
end

# Book class contains information about each book:
# 
# Title - the String to be added
# Author - the String to be added
# Description - the optional String to be added
# Status 
# Due Date
# Renter

class Book
  attr_accessor :status, :due_date, :renter
  attr_reader :title, :author, :description

  def initialize(title, author, description=nil)
    @title = title
    @author = author
    @description = description
    @status = "available"
    @due_date = nil 
    @renter = nil
  end
end

# Library class contains records of users and books
#
# Books - Books are to be added in Array
# Users - Users are to be added in Array

class Library
  attr_accessor :books, :users

  def initialize
    @books = []
    @users = []
  end 

  # Add book to Library books array
  #
  # book - the String to be added
  #
  # Returns the Array with the new book

  def add_book(book)
    if book.is_a?(Book)
      @books << book
    end
  end

  # Add User to users array
  #
  # user - the String to be added
  #
  # Returns the Array with the new user in Library

  def add_user(user)
    @users << user 
  end

  # Check a status on a book in Library
  #
  # e.g. available, checked out, overdue or lost

  def book_status
    @books.each do |book|
      puts "#{book.title}, #{book.status}"
    end
  end

  # Check out available books in the library
  #
  # user, book - the String to be added
  #
  # Returns the Array with the new user + book added to the end

  def check_out(user, book)
    if user.can_rent_books? && book.status == "available" 
      user.rented_books << book

      book.status = "checked out"
      book.due_date = Time.now + (7*24*60*60)
      book.renter = user.name

      puts "#{user.name} checked out #{book.title}."
    else
      puts "Sorry, #{book.title} is unavailable right now."
    end
  end

  # Check in books to the library
  #
  # user, book - the String to be added
  #
  # Returns a message to the user 

  def check_in(user, book)  
    if user.rented_books(book) 
      book.status  = "available"
      book.due_date = nil
      book.renter = nil

      @books << book 

      user.rented_books.delete(book)

      puts "Thanks for returning #{book.title}!"
    else
      puts "You don't have that book to check in."
    end
  end

  # Check for overdue books
  #
  # Returns message to the user

  def overdue? 
    @books.each do |book|
      if book.status == "overdue"
        puts "#{book.title} is overdue. :("
      elsif book.status == "checked out"
        if Time.now > book.due_date
          book.status = "overdue"
          puts "#{book.title} is overdue. :("
        end
      else
        puts "YEAHHBOI There are no overdue books."
      end
    end   
  end

end 

library = Library.new

amy = User.new("amy")
kevin = User.new("kevin")
nicole = User.new("nicole")

derp = Book.new("Derp", "Nyan", "Cats")
herp = Book.new("Herp", "Finn and Jake", "Royal promises")
hamlet = Book.new("Hamlet", "Shakespeare", "Everyone dies")

library.add_book(derp)
library.add_book(herp)
library.add_book(hamlet)

puts "Added all the books. Booyakasha!"

library.book_status

puts "----------------------------"

library.check_out(amy, derp)
library.check_out(kevin, herp)

puts "----------------------------"

library.book_status

puts "----------------------------"

library.check_out(amy, derp)
library.check_out(nicole, derp)

puts "----------------------------"

library.overdue?

puts "----------------------------"

library.check_in(amy, derp)  
library.check_out(nicole, derp)

puts "----------------------------"




require 'csv'

class Person
  attr_reader :id, :first_name, :last_name, :email, :phone, :created_at

  # Look at the above CSV file
  # What attributes should a Person object have?
  def initialize(id, first_name, last_name, email, phone, created_at)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @created_at = created_at
  end
end

class PersonParser
  attr_reader :file

  def initialize(file)
    @file = file
    @people = nil
  end

  def people
    # If we've already parsed the CSV file, don't parse it again.
    # Remember: @people is +nil+ by default.
    return @people if @people

    # We've never called people before, now parse the CSV file
    # and return an Array of Person objects here.  Save the
    # Array in the @people instance variable.
    @people = []
    CSV.foreach("people.csv") do |row|
      new_person = Person.new(row[0], row[1], row[2], row[3], row[4], row[5])
      @people << new_person
    end
    @people.delete_at(0)
    @people
  end

  def add_person(new_person)
    @people << new_person
  end

  def save!
    CSV.open('people.csv', "wb") do |csv|
      csv << "id,first_name,last_name,email,phone,created_at".split(",")
      @people.each do |person|
        text_row = [person.id, person.first_name, person.last_name, person.email, person.phone, person.created_at]
        csv << text_row
      end
    end
  end
end

parser = PersonParser.new('people.csv')

puts "There are #{parser.people.size} people in the file '#{parser.file}'."
puts "The first person is #{parser.people.first.first_name} #{parser.people.first.last_name}."

michael_jordan = Person.new("230", "Michael", "Jordan", "hoops@nba.com", "123-555-3333", "2013-07-06T07:23:09-07:00")
parser.add_person(michael_jordan)

puts "There are #{parser.people.size} people after add_person."
puts "The last person added is #{parser.people.last.first_name} #{parser.people.last.last_name}."

parser.save!


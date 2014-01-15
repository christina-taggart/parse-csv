require 'csv'
require 'date'
class Person
  attr_reader :id, :first_name, :last_name, :email, :phone, :created_at
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
    CSV.foreach(@file, :headers => true) do |row|
      @people << Person.new(row['id'], row['first_name'], row['last_name'], row['email'], row['phone'], DateTime.parse(row['created_at']))
    end
    @people
  end

  def add_person(person)
    @people << person
  end

  def save
    new_file_name = "#{@file}_changed"
    new_file = CSV.open(new_file_name, "wb", :headers => true)
    header_row = []
    CSV.foreach(@file, :headers => false) { |row| header_row << row }
    new_file << header_row.first
    @people.each do |person|
      row_array = [person.id, person.first_name, person.last_name, person.email, person.phone, person.created_at]
      new_file << row_array
    end
  end
end

parser = PersonParser.new('people.csv')

puts "There are #{parser.people.size} people in the file '#{parser.file}'."

p parser.people.each{|x| p x}
parser.add_person(Person.new('201', 'Darcey', 'Lachtman', 'dslachtman@gmail.com', '555-555-5554', DateTime.now))
p parser.people.each{|x| p x}
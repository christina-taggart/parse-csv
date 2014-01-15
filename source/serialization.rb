require 'csv'
require 'pry'
require 'pry-nav'
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
  attr_accessor :file, :people
  def initialize(file)
    @file = file
    @people = nil
  end

  def people
    # If we've already parsed the CSV file, don't parse it again.
    # Remember: @people is +nil+ by default.
    # We've never called people before, now parse the CSV file
    # and return an Array of Person objects here.  Save the
    # Array in the @people instance variable.
    # @people = []
    return @people if @people
    @people = Array.new
    CSV.foreach(@file, :headers => true) do |row|
      @people << Person.new(row['id'], row['first_name'], row['last_name'], row['email'], row['phone'], DateTime.parse(row['created_at']))
    end
    p @people
  end

  def add_person(id, first_name, last_name, email, phone, created_at)
    @people << Person.new(id, first_name, last_name, email, phone, created_at)

  end

  def save
    # p @people

    CSV.open(@file, 'w+') do |csv|
        csv << ['id', 'first_name', 'last_name', 'email', 'phone', 'created_at']
      @people.each do |person|
        csv << [person.id, person.first_name, person.last_name, person.email, person.phone, person.created_at]
      end
    end
  end
end

parser = PersonParser.new('people.csv')
parser.people
parser.add_person("202", "Emmanuel", "Kaunitz", "e.k@gmail.com", "555-111-2222", "2012-04-21T01:57:17-07:00")
parser.save


puts "There are #{parser.people.size} people in the file '#{parser.file}'."
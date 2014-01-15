require 'csv'

class Person
  attr_reader :id, :first_name, :last_name, :email, :phone, :created_at
  # Look at the above CSV file
  # What attributes should a Person object have?
  def initialize(people_hash)
    people_hash.each do |header, value|
      instance_variable_set("@#{header}", value) unless value.nil?
    end
  end
end

class PersonParser
  attr_reader :file

  def initialize(file)
    @file = file
    @people = nil
    @array_of_people = []
  end

  def people
    # If we've already parsed the CSV file, don't parse it again.
    # Remember: @people is +nil+ by default.

    return @people if @people

    # We've never called people before, now parse the CSV file
    # and return an Array of Person objects here.  Save the
    # Array in the @people instance variable.
    CSV.foreach(@file, :headers => true) do |row|
      @array_of_people << Person.new(row)
    end
    @people = @array_of_people
  end

  def add_person(person)
    @array_of_people << person
  end

  def save
    CSV.open('person_new.csv', "a+") do |csv|
      f = CSV.open(@file).to_a.first
      csv << f
       @array_of_people.each do |person|
        csv << [person.id, person.first_name, person.last_name, person.email, person.phone, person.created_at]
       end
    end
  end
end


parser = PersonParser.new('people.csv')
puts "There are #{parser.people.size} people in the file '#{parser.file}'."

parser.add_person Person.new({:id => "201", :first_name => "Elliot", :last_name => "Chalfant", :email => "epchalfant@gmail.com", :phone => "800-000-0000", :created_at => "2013-10-08T04:42:47-07:00"})
parser.save
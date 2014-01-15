require 'csv'
require 'date'

class Person
  attr_reader :id, :first_name, :last_name, :email, :phone, :created_at
  def initialize(person_array)
    @id = person_array[0]
    @first_name = person_array[1]
    @last_name = person_array[2]
    @email = person_array[3]
    @phone = person_array[4]
    @created_at = DateTime.parse(person_array[5])
  end
  # Look at the above CSV file
  # What attributes should a Person object have?
end

class PersonParser
  attr_reader :file, :people

  def initialize(file)
    @file = file
    @people = nil
    get_people_from_csv
  end

  def get_people_from_csv
    # If we've already parsed the CSV file, don't parse it again.
    # Remember: @people is +nil+ by default.
    return @people if @people

    # We've never called people before, now parse the CSV file
    # and return an Array of Person objects here.  Save the
    # Array in the @people instance variable.
    @people = []
    CSV.foreach(file) do |row|
      next if $. == 1
      @people << Person.new(row)
    end
    @people.shift
  end

  def add_person(person_array)
    last_id = @people.last.id
    person_array.unshift((last_id.to_i + 1).to_s)
    person = Person.new(person_array)
    @people << person
  end
end

parser = PersonParser.new('./people.csv')
p parser.people

parser.add_person(['Taggart','Christina','hello@Duis.edu','1-400-270-2222','2013-06-27T17:59:41-07:00'])

p parser.people.last.created_at
# puts "There are #{parser.people.size} people in the file '#{parser.file}'."

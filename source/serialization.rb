require 'csv'

class Person
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
      @people << Person.new(row['id'], row['first_name'], row['last_name'], row['email'], row['phone'], row['created_at'])
    end
    @people
  end
end

parser = PersonParser.new('people.csv')

puts "There are #{parser.people.size} people in the file '#{parser.file}'."
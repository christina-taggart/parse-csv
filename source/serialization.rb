require 'csv'

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
    @people = []
  end

  def people
    source_file = CSV.read(@file)
    source_file.each do |row|
      @people << Person.new(row[0], row[1], row[2], row[3], row[4], row[5])
    end
    # If we've already parsed the CSV file, don't parse it again.
    # Remember: @people is +nil+ by default.
    return @people if @people

    # We've never called people before, now parse the CSV file
    # and return an Array of Person objects here.  Save the
    # Array in the @people instance variable.
  end
end

parser = PersonParser.new('people.csv')
parser.people
puts "There are #{parser.people.size} people in the file '#{parser.file}'."
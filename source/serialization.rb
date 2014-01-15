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
    @people = []
  end

  def people
    CSV.foreach(file) do |row|
      @people << Person.new(row[0], row[1], row[2], row[3], row[4], row[5])
    end
    @people.shift
    return @people if @people
  end
end

parser = PersonParser.new('people.csv')
parser.people

puts "There are #{parser.people.size} people in the file '#{parser.file}'."
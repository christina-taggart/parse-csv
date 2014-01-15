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
    return @people if @people
    @people = []
    CSV.foreach("people.csv", :headers => true) do |row|
      @people << row
      #p row["created_at"]
      row["created_at"] = DateTime.parse(row["created_at"])
    end
    @people
  end


  def add_people(person_added) #need to instantiate a new Person object and pass it in
    array_to_add = [person_added.id, person_added.first_name, person_added.last_name, person_added.email, person_added.phone, person_added.created_at]
    @people << array_to_add
  end


end

parser = PersonParser.new('people.csv')
p parser.people
p parser.add_people(Person.new(201, "alex", "smith", "asmith@gmail.com", "1233433434", "2012-05-13T21:05:15-07:00"))

puts "There are #{parser.people.size} people in the file '#{parser.file}'."
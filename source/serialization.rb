require 'csv'
require 'date'

class Person
  attr_reader :id, :first_name, :last_name, :email, :phone, :created_at
  def initialize(hash)
    @id = hash['id']
    @first_name = hash['first_name']
    @last_name = hash['last_name']
    @email = hash['email']
    @phone = hash['phone']
    @created_at = DateTime.parse(hash['created_at'])
  end

  def to_a
    [@id, @first_name, @last_name, @email, @phone, @created_at]
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
    CSV.foreach(@file, :headers => true) do |row_hash|
      @people << Person.new(row_hash)
    end
  end

  def add_person(person)
    @people << person
  end

  def save
    CSV.open("updated_people.csv", "w") do |csv|
      unparse_people(csv)
    end
  end

  def unparse_people(csv)
    csv << ['id', 'first_name', 'last_name', 'email', 'phone', 'created_at']
    @people.each do |person|
      csv << person.to_a
    end
  end
end


#-----DRIVERS-----

parser = PersonParser.new('people.csv')
parser.people
p parser.people.size == 200

#testing PersonParser#add_person
molly_info = {
  "id" => 201,
  "first_name" => "Molly",
  "last_name" => "Harris",
  "email" => "molly.harris@email.com",
  "phone" => "123-456-7890",
  "created_at" => "2013-12-02T07:45:30-08:00"
}
parser.add_person(Person.new(molly_info))
p parser.people.size == 201

#testing PersonParser#save
parser.save

#testing if created_at is a DateTime object
puts parser.people[0].created_at.class == DateTime
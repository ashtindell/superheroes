require 'pg'

# TODO: rename this file to superheroes.rb

# TODO: change the name of the class
class SuperheroesConnection

  def initialize
    # TODO: change the dbname to 'superheroes'
    @conn = PG.connect(:dbname =>'superheroes', :host => 'localhost')
    # TODO: change the insert to insert a superhero
    @conn.prepare("insert_superheroes", "INSERT INTO superheroes (name, alter_ego, has_cape, power, arch_nemesis) VALUES ($1, $2, $3, $4, $5)")
  end

  def delete_all
    # TODO: fix this
    @conn.exec( "delete from superheroes" )
  end

  def insert_superheroes(name, alter_ego, has_cape, power, arch_nemesis)
    # TODO: fix this
    @conn.exec_prepared("insert_superheroes", [name, alter_ego, has_cape, power, arch_nemesis])
  end

  # TODO: change method name
  def print_superheroes
    # TODO: fix this
    @conn.exec( "select * from superheroes order by name desc" ) do |result|
      result.each do |row|
        # TODO: fix this to pretty print the superheroes
        puts row
        alter_ego = row['alter_ego'] || 'null'
        # dob = row['dob'] || 'null'
        puts "#{row['name']}'s alter ego is #{alter_ego}!"
        # puts "#{row['first']} #{row['last']} was born on #{dob}"
      end
    end
  end

  def close
    @conn.close
  end
end

begin
  # TODO: fix this
  connection = SuperheroesConnection.new

  # connection.delete_all

  # TODO: insert superheroes here.
  connection.insert_superheroes('Batman',            'Bruce Wayne',          'true',  'none',                  'Joker')
  connection.insert_superheroes('Superman',          'Clark Kent',           'true',  'superhuman',            'Lex Luther')
  connection.insert_superheroes('Captain America',   'Steve Rogers',         'false', 'superhuman',            'Nazis')
  connection.insert_superheroes('Iron Man',          'Tony Stark',           'false', 'suit of power armor',   'Mandarin')
  connection.insert_superheroes('Spider-Man',        'Peter Parker',         'false', 'spider-like abilities', 'Green Goblin')
  connection.insert_superheroes('Wolverine',         'James Howlett Hudson', 'false', 'metal skeleton',        'Sabretooth') 

  # TODO: fix this to use better method name
  connection.print_superheroes
rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
ensure
  connection.close
end

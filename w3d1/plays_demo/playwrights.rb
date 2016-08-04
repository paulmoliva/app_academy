require 'sqlite3'
require 'singleton'
require_relative 'plays.rb'


class Playwright
  attr_accessor :name, :birth_year

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map{|datum| Playwright.new(datum)}
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    #raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
      INSERT INTO
        playwrights(name, birth_year)
      VALUES
        (?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in databse" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def self.find_by_name(name)
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights WHERE name = \'#{name}\'")
    data.map{|datum| Playwright.new(datum)}
  end

  def get_plays
    data = PlayDBConnection.instance.execute("SELECT * FROM plays WHERE playwright_id = #{@id}")
    puts data
    data.map{|datum| Play.new(datum)}
  end
end

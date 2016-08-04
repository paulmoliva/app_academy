require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    puts "WOrked"
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    #raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def self.find_by_title(title)
    data = PlayDBConnection.instance.execute("SELECT * FROM plays WHERE title = \'#{title}\'")
    data.map{|datum| Play.new(datum)}
  end


  def self.find_by_playwright(name)
    data = PlayDBConnection.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        plays JOIN playwrights ON playwrights.id = play.playwright_id
      WHERE
        playwrights.name = \'#{name}\'
      SQL
  end


end

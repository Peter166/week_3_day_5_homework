require_relative("../db/sql_runner")
class Film
  attr_reader :id
  attr_accessor :title, :price, :remaining_tickets

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
    @remaining_tickets = options['remaining_tickets']
  end

  def save()
    sql = "INSERT INTO films (title, price, remaining_tickets) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @price,@remaining_tickets]
    film = SqlRunner.run(sql, values).first
    @id = film["id"].to_i()
  end


  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    result = films.map {|film| Film.new(film)}
    return result
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films SET (title, price, remaining_tickets) = ($1, $2, $3)
    WHERE id = $4"
    values = [@title, @price, @remaining_tickets, @id]
    result = SqlRunner.run(sql, values)
  end

  def customers()
    # for this movie go to customer and get me customers who is assignt to this movie
    sql = "SELECT customers.*
    FROM customers INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE film_id = $1"
    values = [@id]
    customers_data = SqlRunner.run(sql, values)
    result = customers_data.map {|customer| Customer.new(customer)}
    return result
  end


  def how_many_customers()
    sql = "SELECT * FROM tickets
    WHERE film_id = $1"
    values =[@id]
    result = SqlRunner.run(sql, values)
    return result.count()
  end
end

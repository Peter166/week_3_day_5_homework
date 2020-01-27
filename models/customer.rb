
require_relative("../db/sql_runner")
require_relative("../models/ticket")
class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end


  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map {|person| Customer.new(person)}
    return result
  end


  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    result = SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.*
    FROM films INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE customer_id = $1"
    values = [@id]
    films_data = SqlRunner.run(sql, values)
    result = films_data.map {|film| Film.new (film)}
    return result
  end


  def tickets()
    sql = "SELECT *
    FROM tickets
    WHERE customer_id = $1"
    values = [@id]
    tickets_data = SqlRunner.run(sql, values)
    return tickets_data.map{|ticket| Ticket.new(ticket)}
  end

  def buy_ticket(film, screening)
    return "You don't have enough money." unless @funds > film.price.to_i
    return "tickets sold out." unless screening.remaining_tickets.to_i > 0
    

    screening.remaining_tickets -= 1
    @funds -= film.price.to_i
    sql = "INSERT INTO tickets (customer_id, film_id, screening_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@id, film.id, screening.id]
    ticket = SqlRunner.run(sql, values).first
    ticket[:id] = ticket["id"].to_i()
  end

def how_many_tickets()
  sql = "SELECT * FROM tickets
  WHERE customer_id = $1"
  values =[@id]
  result = SqlRunner.run(sql, values)
  return result.count()
end




  # values =[@id, film.id]
  # Ticket.save()


end

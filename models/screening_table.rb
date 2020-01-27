require_relative('../db/sql_runner.rb')



class Screening

  attr_reader :id
  attr_accessor  :show_time, :film_id, :remaining_tickets

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @show_time = options['show_time']
    @film_id = options['film_id']
    @remaining_tickets = options["remaining_tickets"]



  end


  def save()
    sql = "INSERT INTO screenings (show_time, film_id, remaining_tickets) VALUES ($1, $2, $3) RETURNING id"
    values = [@show_time, @film_id, @remaining_tickets]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket["id"].to_i()
  end



  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end
  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    tickets = SqlRunner.run(sql)
    result = tickets.map {|person| Screening.new(person)}
    return result
  end

  def update()
    sql = "UPDATE screenings SET (show_time, film_id, remaining_tickets) = ($1, $2, $3)
    WHERE id = $4"
    values = [@show_time, @film_id, @remaining_tickets]
    result = SqlRunner.run(sql, values)
  end

  # def best_movie()
  #   sql = "select * from films INNER JOIN tickets ON films.id = tickets.film_id WHERE film_id = 1"
  #   values = [@film_id]
  #   result1 = SqlRunner.run(sql)
  #   sql = "select * form film INNER JOIN tickets "
  # end
  #
  #
  #   def find_popular()
  #
  #     sql = "SELECT screenings.show_time
  #   FROM screenings INNER JOIN tickets
  #   ON tickets.screening_id = screenings.id WHERE tickets.film_id = $1"
  #   result
  # end

  def find_popular_time()
    sql = "SELECT screenings
    FROM screenings INNER JOIN tickets
    ON tickets.screening_id = screenings.id
    GROUP BY screenings.show_time
    ORDER BY COUNT(*) DESC"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result[0]["show_time"]
  end

  def self.find_best()
    sql = "SELECT customers.*
    FROM customers INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE film_id = $1"
    film = SqlRunner.run(sql)


    return "film1 is more popular" unless film1 < film2
  end

end

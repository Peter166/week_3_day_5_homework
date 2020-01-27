require('pry')

require_relative( 'models/ticket')
require_relative( 'models/film')
require_relative( 'models/customer')
require_relative( 'models/screening_table')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()


customer1 = Customer.new({'name' => 'Bob', 'funds'=>3})
customer1.save()
customer1.name = 'Bober'
customer1.update()
customer2 = Customer.new({'name' => 'Roger', 'funds'=>5})
customer2.save()
customer3 = Customer.new({'name' => 'Dodger', 'funds'=>7})
customer3.save()
customer4 = Customer.new({'name' => 'Badger', 'funds'=>2})
customer4.save()

film1 = Film.new({'title' => 'Slow and Calm', 'price'=>2})
film1.save()
film2 = Film.new({'title' => 'The Darkning', 'price'=>5})
film2.save()
# film3 = Film.new({'title' => 'Safarnji', 'price'=>3})
# film3.save()
# film4 = Film.new({'title' => 'The Square', 'price'=>6})
# film4.save()

screening1 = Screening.new({'show_time'=> '17:00', 'film_id' => film1.id,'remaining_tickets' => 1 })
screening1.save
screening2 = Screening.new({'show_time'=> '17:30', 'film_id' => film2.id, 'remaining_tickets' => 2})
screening2.save


ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id'=>film1.id, 'screening_id'=> screening1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id'=>film2.id, 'screening_id'=> screening2.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id'=>film1.id, 'screening_id'=> screening1.id})
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id'=>film1.id, 'screening_id'=> screening1.id})
ticket4.save()
ticket5 = Ticket.new({'customer_id' => customer2.id, 'film_id'=>film1.id, 'screening_id'=> screening1.id})
ticket5.save()



binding.pry
Screening.find_best()
nil

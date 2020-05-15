class RentalsMailer < ApplicationMailer
  # def scheduled(rental) #Primeira forma de fazer
  #   mail(subject: "Confirmação de Agendamento - #{rental.code}")
  # end

  def scheduled(rental)  #segunda forma de fazer
    emails = Customer.pluck(:email) #pluck usa só a coluna do banco de dados e joga em um array no caso email
    @rental = rental
    mail(to: @rental.customer.email, 
          subject: "Confirmação de Agendamento - #{@rental.code}")
  end 
end
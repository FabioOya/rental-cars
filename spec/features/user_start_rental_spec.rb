require 'rails_helper'

feature 'User start rental' do
  scenario 'successfully' do
    manufacturer = create(:manufacturer) #GEM Factory_bot
    #manufacturer = Manufacturer.create!(name:'Fiat')
    car_category = create(:car_category, name: 'A') #GEM Factory_bot
    # car_category = CarCategory.create!(name: 'A', daily_rate: 100, 
    #                                     car_insurance: 100, 
    #                                     third_party_insurance: 100)
    car_model = create(:car_model, manufacturer: manufacturer, 
                                  car_category: car_category) #GEM Factory_bot
    # car_model = CarModel.create!(name: 'Uno', year: 2020, fuel_type: 'Flex',
    #                              manufacturer: manufacturer, 
    #                              motorization: '1.0', 
    #                              car_category: car_category)
    car  = create(:car, license_plate: 'ABC1234', car_model: car_model)#GEM Factory_bot
    # car = Car.create!(license_plate: 'ABC1234', color: 'Branco', 
    #                   car_model: car_model, mileage: 0)
    customer = create(:customer, name: 'Fulano Sicrano', 
                                 email: 'teste@teste.com.br')
    # customer = Customer.create!(name: 'Fulano Sicrano', 
    #                             document:'829.718.911-27',  
    #                             email:'teste@teste.com.br')
    rental = create(:rental, customer: customer, car_category: car_category)
    # rental = Rental.create!(customer: customer, car_category: car_category,
    #                         start_date: 1.day.from_now, 
    #                         end_date: 2.days.from_now)
    user = create(:user, email: 'test@test.com.br')
    # user = User.create!(email: 'test@test.com.br', password: '12345678')

    login_as user, scope: :user
    visit search_rentals_path(q: rental.code)
    click_on 'Iniciar'
    select car.license_plate, from: 'Carro'
    click_on 'Confirmar locação'

    expect(page).to have_content(I18n.l(Time.zone.now, format: :long))
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content ('Em progresso')
    expect(page).to have_content(user.email)
  end
end
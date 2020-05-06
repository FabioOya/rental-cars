require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'succesfully' do
    # Arrange

    CarCategory.create!(name: 'A', daily_rate: 50)
    CarCategory.create!(name: 'B', daily_rate: 70)
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    
    # Act
    
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de carros'

    # Assert

    expect(page).to have_content 'Categoria A'
    expect(page).to have_content 'R$ 50,00'

    expect(page).to have_content 'Categoria B'
    expect(page).to have_content 'R$ 70,00'
  end

  scenario 'and view details' do
    car_category =  CarCategory.create!(name: 'A', daily_rate: 50,
                                        car_insurance: 40,
                                        third_party_insurance: 30)
    manufacturer = Manufacturer.create!(name: 'Fiat')
    uno = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer,
                          motorization: '1.0', fuel_type: 'Flex', 
                          car_category: car_category)
    mobi = CarModel.create!(name: 'Mobi', year: 2020, manufacturer: manufacturer,
                          motorization: '1.0', fuel_type: 'Flex', 
                          car_category: car_category)
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    
    
    #CarCategory.create!(name: 'A', daily_rate: 200, car_insurance: 100.50, third_party_insurance: 120)
    #CarCategory.create!(name: 'B', daily_rate: 300, car_insurance: 150, third_party_insurance: 120)
    
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Categoria A'

    expect(page).to have_css('header h1', text: 'Categoria A')
    expect(page).to have_content 'Diária: R$ 50,00'
    expect(page).to have_content 'Seguro do Carro: R$ 40,00'
    expect(page).to have_content 'Seguro para terceiros: R$ 30,00'

    expect(page).not_to have_content 'Categoria B'
    expect(page).not_to have_content'Diária: R$ 300,00'
    expect(page).not_to have_content'Seguro do Carro: R$ 150,00'
    expect(page).to have_link('Uno', href: car_model_path(uno))
    expect(page).to have_link('Mobi', href: car_model_path(mobi))
    expect(page).to have_link('Voltar', href: car_categories_path)
  end

  scenario 'and no car categories are created' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end
    
  scenario 'and return to car categories page' do
    CarCategory.create!(name: 'Compactos', daily_rate: 200, car_insurance: 100.50, third_party_insurance: 120)
    CarCategory.create!(name: 'Familia', daily_rate: 300, car_insurance: 150, third_party_insurance: 120)
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Compactos'
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end  
  
  scenario 'and view filtered car models' do
    car_category_a =  CarCategory.create!(name: 'A', daily_rate: 50,
                                          car_insurance: 40,
                                          third_party_insurance: 30)
    car_category_b =  CarCategory.create!(name: 'B', daily_rate: 50,
                                          car_insurance: 40,
                                          third_party_insurance: 30)
    manufacturer = Manufacturer.create!(name: 'Fiat')
    uno = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer,
                           motorization: '1.0', fuel_type: 'Flex', 
                           car_category: car_category_a)
    argos = CarModel.create!(name: 'Argos', year: 2020, manufacturer: manufacturer,
                             motorization: '1.0', fuel_type: 'Flex', 
                             car_category: car_category_b)

    user = User.create!(email: 'test@test.com.br', password: '12345678')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Categoria A'

    expect(page).to have_link('Uno', href: car_model_path(uno))
    expect(page).not_to have_link('Argos')
  end
end
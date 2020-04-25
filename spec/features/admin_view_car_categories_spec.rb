require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'succesfully' do
    # Arrange

    CarCategory.create!(name: 'A', daily_rate: 50)
    CarCategory.create!(name: 'B', daily_rate: 70)
    # Act

    visit root_path
    click_on 'Categorias de carros'

    # Assert

    expect(page).to have_content 'Categoria A'
    expect(page).to have_content 'R$ 50,00'

    expect(page).to have_content 'Categoria B'
    expect(page).to have_content 'R$ 70,00'
  end

  scenario 'and view details' do
    CarCategory.create!(name: 'A', daily_rate: 200, car_insurance: 100.50, third_party_insurance: 120)
    CarCategory.create!(name: 'B', daily_rate: 300, car_insurance: 150, third_party_insurance: 120)

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Categoria A'

    expect(page).to have_css('header h1', text: 'A')
    expect(page).to have_content 'Categoria A'
    expect(page).to have_content 'Diária: R$ 200,00'
    expect(page).to have_content 'Seguro do Carro: R$ 100,50'
    expect(page).to have_content 'Seguro para terceiros: R$ 120,00'

    expect(page).not_to have_content 'Categoria B'
    expect(page).not_to have_content'Diária: R$ 300,00'
    expect(page).not_to have_content'Seguro do Carro: R$ 150,00'
  end

  scenario 'and no car categories are created' do
    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end
    
  scenario 'and return to car categories page' do
    CarCategory.create!(name: 'Compactos', daily_rate: 200, car_insurance: 100.50, third_party_insurance: 120)
    CarCategory.create!(name: 'Familia', daily_rate: 300, car_insurance: 150, third_party_insurance: 120)

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Compactos'
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end  
end
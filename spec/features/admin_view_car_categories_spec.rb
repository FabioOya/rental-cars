require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'succesfully' do
    CarCategory.create!(name: 'Compactos', daily_rate: 200, car_insurance: 100.50, third_party_insurance: 120)
    CarCategory.create!(name: 'Familia', daily_rate: 300, car_insurance: 150, third_party_insurance: 120)

    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_content('Compactos')
    expect(page).to have_content('Familia')
  end

  scenario 'and view details' do
    CarCategory.create!(name: 'Compactos', daily_rate: 200, car_insurance: 100.50, third_party_insurance: 120)
    CarCategory.create!(name: 'Familia', daily_rate: 300, car_insurance: 150, third_party_insurance: 120)

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Compactos'

    expect(page).to have_content('Compactos')
    expect(page).to have_content(200)
    expect(page).to have_content(100.50)
    expect(page).to have_content(120)
    expect(page).not_to have_content('Familia')
    expect(page).not_to have_content(300)
    expect(page).not_to have_content(150)
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
require 'rails_helper'

feature 'Admin register car category' do
  scenario 'from index page' do
    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_link('Registrar categoria', href: new_car_category_path)
  end
    
  scenario 'succesfully' do
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Registrar categoria'

    fill_in 'Nome', with: 'Compactos'
    fill_in 'Taxa Diaria', with: 200
    fill_in 'Seguro', with: 100.50
    fill_in 'Seguro de terceiros', with: 120
    click_on 'Enviar'

    expect(current_path).to eq car_category_path(CarCategory.last.id)
    expect(page).to have_content('Compactos')
    expect(page).to have_content(200)
    expect(page).to have_content 'Seguro do Carro: R$ 100,50'
    expect(page).to have_content(120)
    expect(page).to have_link('Voltar')
  end
end
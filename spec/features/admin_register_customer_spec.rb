require 'rails_helper'

feature 'Admin register customer' do
  scenario 'from index page' do
    visit root_path
    click_on 'Clientes'
        
    expect(page).to have_link('Registrar novo cliente', href: new_customer_path)
  end

  scenario 'succesfully' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Fabio'
    fill_in 'CPF', with: '84436985248'
    fill_in 'E-mail', with: 'fabio_iwao@hotmail.com'
    click_on 'Enviar'

    expect(current_path).to eq customer_path(Customer.last.id)
    expect(page).to have_content('Fabio')
    expect(page).to have_content('84436985248')
    expect(page).to have_content('fabio_iwao@hotmail.com')
    expect(page).to have_link('Voltar')
  end
end
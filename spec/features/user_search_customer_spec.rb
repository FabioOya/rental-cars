require 'rails_helper'

feature 'user search customer' do
  scenario 'by exact name' do
    user = User.create!(email: 'email@test.com', password: '12345678')
    customer = Customer.create!(name: 'Fulano Sicrano', 
                                email: 'fulano@email.com', 
                                document: '252.454.586-59')
    another_customer = Customer.create!(name: 'João da Silva', 
                                        email: 'joao@dasilva.com', 
                                        document: '162.537.843-23')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: customer.name
    click_on 'Buscar'

    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.document)
    expect(page).not_to have_content(another_customer.name)
    expect(page).not_to have_content(another_customer.email)
    expect(page).not_to have_content(another_customer.document)
  end

  scenario 'by partial name' do
    user = User.create!(email: 'email@test.com', password: '12345678')
    customer = Customer.create!(name: 'Fulano Sicrano', 
                                email: 'fulano@email.com', 
                                document: '252.454.586-59')
    another_customer = Customer.create!(name: 'João da Silva', 
                                        email: 'joao@dasilva.com', 
                                        document: '162.537.843-23')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: 'fulano'
    click_on 'Buscar'

    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.document)
    expect(page).not_to have_content(another_customer.name)
    expect(page).not_to have_content(another_customer.email)
    expect(page).not_to have_content(another_customer.document)
  end

  xscenario 'finds nothing' do
  end
end
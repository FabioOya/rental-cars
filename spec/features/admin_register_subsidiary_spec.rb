require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'from index page' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar filial', href: new_subsidiary_path)   
  end

  scenario 'succesfully' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar filial'

    fill_in 'Nome', with: 'Uma Filial'
    fill_in 'CNPJ', with: '55.516.423/0001-50'
    fill_in 'Endereço', with: 'Rua tal'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last.id)
    expect(page).to have_content('Uma Filial')
    expect(page).to have_content('55.516.423/0001-50')
    expect(page).to have_content('Rua tal')
    expect(page).to have_link('Voltar')
  end
end
require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'succesfully' do
    Subsidiary.create!(name: 'Uma filial', cnpj: '93.188.470/0001-01', adress: 'Um endereço')   
    Subsidiary.create!(name: 'Outra filial', cnpj: '72.054.980/0001-16', adress: 'Outro endereço')
    user = User.create!(email: 'test@test.com.br', password: '12345678')
     
    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Uma filial')
    expect(page).to have_content('Outra filial')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Uma filial', cnpj: '93.188.470/0001-01', adress: 'Um endereço')
    Subsidiary.create!(name: 'Outra filial', cnpj: '72.054.980/0001-16', adress: 'Outro endereço')
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'
    click_on 'Uma filial'

    expect(page).to have_content('Uma filial')
    expect(page).to have_content('93.188.470/0001-01')
    expect(page).to have_content('Um endereço')
    expect(page).not_to have_content('Outra filial')
    expect(page).not_to have_content('72.054.980/0001-16')
    expect(page).not_to have_content('Outro endereço')
  end

  scenario 'and no subsidiaries are created' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'
        
     expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Uma filial', cnpj: '93.188.470/0001-01', adress: 'Um endereço')
    Subsidiary.create!(name: 'Outra filial', cnpj: '72.054.980/0001-16', adress: 'Outro endereço')
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries page' do
    Subsidiary.create!(name: 'Uma filial', cnpj: '93.188.470/0001-01', adress: 'Um endereço')
    Subsidiary.create!(name: 'Outra filial', cnpj: '72.054.980/0001-16', adress: 'Outro endereço')
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'
    click_on 'Uma filial'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end
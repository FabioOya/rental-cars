require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'succesfully' do
    Subsidiary.create!(name: 'Uma filial', cnpj: 'Um cnpj', adress: 'Um endereço')   
    Subsidiary.create!(name: 'Outra filial', cnpj: 'Outro cnpj', adress: 'Outro endereço')
        
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Uma filial')
    expect(page).to have_content('Outra filial')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Uma filial', cnpj: 'Um cnpj', adress: 'Um endereço')
    Subsidiary.create!(name: 'Outra filial', cnpj: 'Outro cnpj', adress: 'Outro endereço')

    visit root_path
    click_on 'Filiais'
    click_on 'Uma filial'

    expect(page).to have_content('Uma filial')
    expect(page).to have_content('Um cnpj')
    expect(page).to have_content('Um endereço')
    expect(page).not_to have_content('Outra filial')
    expect(page).not_to have_content('Outro cnpj')
    expect(page).not_to have_content('Outro endereço')
  end

  scenario 'and no subsidiaries are created' do
    visit root_path
    click_on 'Filiais'
        
     expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Uma filial', cnpj: 'Um cnpj', adress: 'Um endereço')
    Subsidiary.create!(name: 'Outra filial', cnpj: 'Outro cnpj', adress: 'Outro endereço')

    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries page' do
    Subsidiary.create!(name: 'Uma filial', cnpj: 'Um cnpj', adress: 'Um endereço')
    Subsidiary.create!(name: 'Outra filial', cnpj: 'Outro cnpj', adress: 'Outro endereço')

    visit root_path
    click_on 'Filiais'
    click_on 'Uma filial'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end
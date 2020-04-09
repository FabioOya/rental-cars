require 'rails_helper'

feature 'Admin register subsidiary' do
    scenario 'from index page' do
        visit root_path
        click_on 'Filiais'

        expect(page).to have_link('Registrar filial', href: new_subsidiary_path)   
    end

    scenario 'succesfully' do
        visit root_path
        click_on 'Filiais'
        click_on 'Registrar filial'

        fill_in 'Nome', with: 'Uma Filial'
        fill_in 'CNPJ', with: 'XX.XXX.XXX/XXXX-XX'
        fill_in 'Endereço', with: 'Rua tal'
        click_on 'Enviar'

        expect(current_path).to eq subsidiary_path(Subsidiary.last.id)
        expect(page).to have_content('Uma Filial')
        expect(page).to have_content('XX.XXX.XXX/XXXX-XX')
        expect(page).to have_content('Rua tal')
        expect(page).to have_link('Voltar')
    end
end
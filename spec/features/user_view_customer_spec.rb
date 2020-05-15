require 'rails_helper'

feature 'User view customer' do
  # before(:each) do    #Caso TODOS os teste necessitem usuario logado
  #   user = create(:user)
  #   login_as user, scope: :user 
  # end

  xscenario 'and view multiple customers'do
  end

  xscenario 'and view customer detailsi' do
    within "tr#rental-#{rental.code}" do
      click_on 'Iniciar'
    end
  end

  xscenario 'without rentals' do

    expect(page).to_not have_link ('Iniciar')
  end
end


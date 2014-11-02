require 'spec_helper'

feature 'Create game', js: true do
  before do
    @user = FactoryGirl.create(:confirmed_user)
    @login_page = LoginPage.new
    @login_page.visit
    @login_page.sign_in(@user.email, @user.password)
  end

  feature 'create game' do
    scenario 'games page should have new game url' do
      click_on 'Games'
      expect(page).to have_content('Create new game')
    end
  end
end

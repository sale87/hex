require 'spec_helper'

feature 'Authentication', js: true do
  before do
    @user = FactoryGirl.create(:confirmed_user)
    @login_page = LoginPage.new
    @login_page.visit
  end

  feature 'login' do
    scenario 'with valid inputs' do
      @login_page.sign_in(@user.email, @user.password)
      expect(page).to have_content('Sign out')
    end

    scenario 'redirect after login' do
      @login_page.sign_in(@user.email, @user.password)
      expect(page).to have_content('Welcome to Hex!')
    end

  scenario 'with invalid credentials' do
      @login_page.sign_in('notexisting@email.com', 'blabla')
      expect(page).to have_content('Invalid login credentials. Please try again.')
    end
  end
end

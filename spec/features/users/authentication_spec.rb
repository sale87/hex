require 'spec_helper'

feature 'Authentication', js: true do
  feature 'login' do
    scenario 'with valid inputs' do
      @user = FactoryGirl.create(:confirmed_user)
      visit '#/sign_in'
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      find("button", text: "Sign in").click

      expect(page).to have_content('Welcome to Hex!')
    end
  end
end

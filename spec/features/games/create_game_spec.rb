require 'spec_helper'

feature 'Create game', js: true do
  include Capybara::Angular::DSL

  before(:each) do
    @user = FactoryGirl.create(:confirmed_user)
    @login_page = LoginPage.new
    @login_page.visit
    @login_page.sign_in(@user.email, @user.password)
  end

  scenario 'games page should have new game url' do
    click_on 'Games'
    click_on 'Create new game'
    fill_in 'description', with: 'This is my game.'
    fill_in 'timepermove', with: '1'
    click_on 'Create game'
    expect(page).to have_content('This is my game.')
  end
end

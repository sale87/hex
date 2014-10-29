require 'spec_helper'

feature "Registration", js: true do
  scenario "with valid inputs" do
    visit "#/sign_up"

    email, password = Faker::Internet.email, Faker::Internet.password
    nickname, name = Faker::Internet.user_name, Faker::Name.name
    fill_in "Email", with: email
    fill_in "Nickname", with: nickname
    fill_in "Name", with: name
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_on "Sign Up"

    expect(page).to have_content('Sign out')
    expect(page).to have_content('Welcome to Hex!')
    expect(page).to have_content(nickname)
    expect(page).to have_content(name)
  end
end

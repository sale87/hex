require 'spec_helper'

feature "Registration", js: true do
  scenario "with valid inputs" do
    visit "#/sign_up"

    email = Faker::Internet.email
    password = Faker::Internet.password
    name = Faker::Name.name
    fill_in "Email", with: email
    fill_in "Name", with: name
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_on "Sign Up"

    expect(page).to have_content('Sign out')
    expect(page).to have_content('Welcome to Hex!')
    expect(page).to have_content(name)
  end

  scenario "with invalid email" do
    visit "#/sign_up"

    password = Faker::Internet.password
    name = Faker::Name.name
    fill_in "Email", with: 'not-valid'
    fill_in "Name", with: name
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_on "Sign Up"

    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Email is invalid.')
  end

end

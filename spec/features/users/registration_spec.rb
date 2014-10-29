require 'spec_helper'

feature "Registration", js: true do
  let(:name) {Faker::Name.name}
  let(:email) {Faker::Internet.email}
  let(:password) {Faker::Internet.password}

  before do
    @sign_up_page = SignUpPage.new
    @sign_up_page.visit
  end

  scenario "with valid inputs" do
    @sign_up_page.sign_up(email: email, name: name, password: password, password_confirmation: password)

    expect(page).to have_content('Sign out')
    expect(page).to have_content('Welcome to Hex!')
    expect(page).to have_content(name)
  end

  scenario "with invalid email" do
    @sign_up_page.sign_up(email: 'not-valid', name: name, password: password, password_confirmation: password)

    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Email is invalid.')
  end

  scenario "with invalid password" do
    password = 'a'
    @sign_up_page.sign_up(email: email, name: name, password: password, password_confirmation: password)

    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Password is too short (minimum is 8 characters).')
  end

  scenario "with password confirmation missmatch" do
    @sign_up_page.sign_up(email: email, name: name, password: password, password_confirmation: 'password_mismatch')

    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Password confirmation doesn\'t match Password.')
  end

end

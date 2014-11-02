class LoginPage
  include Capybara::DSL

  def visit
    Capybara::visit '#/sign_in'
  end

  def sign_in(email, password)
    fill_in "email", with: email
    fill_in "password", with: password
    click_button 'Sign in'
  end
end

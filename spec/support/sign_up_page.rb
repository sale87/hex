class SignUpPage
  include Capybara::DSL

  def visit
    Capybara::visit '#/sign_up'
  end

  def sign_up(options)
    fill_in 'Email', with: options[:email]
    fill_in 'Name', with: options[:name]
    fill_in 'Password', with: options[:password]
    fill_in 'Password confirmation', with: options[:password_confirmation]
    click_button 'Sign Up'
  end
end

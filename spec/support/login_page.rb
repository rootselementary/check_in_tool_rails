class LoginPage
  include Capybara::DSL

  def visit_page
    visit '/'
    click_on 'Login'
    self
  end

  def login(user)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on 'Log In'
  end
end

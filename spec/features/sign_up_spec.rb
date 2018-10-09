require 'spec_helper'
require 'rails_helper'
require 'support/spec_test_helper'

RSpec.feature "Signup into Hiker App", :type => :feature do

  scenario "Signup user into Hiker App " do
    visit root_path
    click_link("Sign Up")
    expect("localhost:3000/users/new")
    user = create(:user)

    fill_in 'user_name', with: user.name
    fill_in 'user_surname', with: user.surname
    fill_in 'user_nickname', with: user.nickname
    fill_in 'user_email', with: user.name
    fill_in 'user_city', with: user.city
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password

    click_button 'Signup'
    expect("localhost:3000/login")
  end
end

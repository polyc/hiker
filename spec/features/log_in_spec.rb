require 'spec_helper'
require 'rails_helper'
require 'support/spec_test_helper'

RSpec.feature "Login into Hiker App", :type => :feature do

  before :each do
    visit root_path
    click_link("Log In")
  end

  scenario "login with email" do
    expect("localhost:3000/login")
    user = create(:user)
    fill_in 'username_or_email', with: user.email
    fill_in 'login_password', with: user.password
    click_button 'Log In'
  end

  scenario "login with username" do
    expect("localhost:3000/login")
    user = create(:user)
    fill_in 'username_or_email', with: user.nickname
    fill_in 'login_password', with: user.password
    click_button 'Log In'
  end

  scenario "login with facebook" do
    pending
  end
end

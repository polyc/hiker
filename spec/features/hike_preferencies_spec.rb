require 'spec_helper'
require 'rails_helper'
require 'support/spec_test_helper'

RSpec.feature "Hike preferencies setup", :type => :feature do

  scenario "set hike preferencies" do
    visit root_path
    click_link("Log In")
    expect("localhost:3000/log_in")
    user = create(:user)
    fill_in 'username_or_email', with: user.email
    fill_in 'login_password', with: user.password
    click_button 'Log In'

    expect("localhost:3000/home")
    visit user_path(user)
    expect("localhost:3000/profile")
    visit hike_preferencies_setup_path
    expect("localhost:3000/hike_preferencies_setup")

    expect(page).to have_checked_field("hike_pref[]")
    click_button("Go to my Home Feed")
    expect("localhost:3000/profile")
  end
end

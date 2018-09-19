Given("I am on the Hiker landing page") do
  visit("localhost:3000")
end

When("I click on login button") do
  click_link('login')
end

Then("I should see login page") do
  #page.find_by_id("username_or_email")
  expect("localhost:3000/login").to have_field(page.find_by_id("username_or_email"))
  #expect("localhost:3000/login").to have_field("login_password")
  #expect("localhost:3000/login").to have_link("Log In")
  #expect("localhost:3000/login").to have_link("Sign in with Facebook")
end

Given("I am on the Hiker login page") do
  visit("localhost:3000/login")
end

When("I sign in") do
  click_link("Log In")
end

Then("I should see my homefeed") do
  pending
  #expect("localhost:3000/home")
end

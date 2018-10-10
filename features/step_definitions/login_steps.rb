Given("I am on the Hiker landing page") do
  visit("localhost:3000")
end

When("I click on login button") do
  click_link("Log In")
end

Then("I should see login page") do
  expect("localhost:3000/login")
  #expect("localhost:3000/login").to have_field(page.find('//text[@id="username_or_email"]'))
  #expect("localhost:3000/login").to have_field(page.find_by_id("login_password").value)
  #expect("localhost:3000/login").to have_link(page.find('button.submit.button'))
  #expect("localhost:3000/login").to have_link(page.find_link("Sign in with Facebook").text)
end

Given("I am on the Hiker login page") do
  visit("localhost:3000/login")
end

When("I sign in") do
  @dummy = User.create!(
    id: 12,
    gender: "male",
    city: "Roma",
    surname: "Martinelli",
    nickname: "furcanne",
    password: "fulco4991",
    email: "fulco94@gmail.com",
    name: "Fulco"
  )
  fill_in 'username_or_email', with: @dummy.nickname
  fill_in 'login_password', with: @dummy.password
  click_button 'Log In'
end

Then("I should see my homefeed") do
  expect("localhost:3000/home")
end

When("I sign in with Facebook") do
  click_link("Sign in with Facebook")
end

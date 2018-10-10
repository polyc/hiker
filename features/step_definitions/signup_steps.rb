Given("Given I am on the Hiker landing page") do
  visit("localhost:3000")
end

When("I click on signup button") do
  click_link("Sign Up")
end

Then("I should see signup page") do
  expect("localhost:3000/users/new")
end

Given("I am on the Hiker signup page") do
  visit("localhost:3000/users/new")
end

When("I signup") do
  @dummy = User.create!(
    id: 1,
    gender: "male",
    city: "Roma",
    surname: "Martinelli",
    nickname: "furcanne1234",
    password: "fulco4991",
    email: "fulco94@gmail.com",
    name: "Fulco"
  )
  fill_in 'user_name', with: @dummy.name
  fill_in 'user_surname', with: @dummy.surname
  fill_in 'user_nickname', with: @dummy.nickname
  fill_in 'user_email', with: @dummy.name
  fill_in 'user_city', with: @dummy.city
  fill_in 'user_password', with: @dummy.password
  fill_in 'user_password_confirmation', with: @dummy.password

  click_button 'Signup'
end

Then("I should see hike preferences setup page") do
  expect("localhost:3000/login")
end

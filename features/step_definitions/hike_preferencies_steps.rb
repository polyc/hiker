Given("I am on the set hike preferencies setup page") do
  visit("localhost:3000/hike_preferencies_setup")
end

Given("I am signed in in the Hike App") do
  @dummy = User.create(
    id: 1,
    gender: "male",
    city: "Roma",
    surname: "Martinelli",
    nickname: "furcanne1234",
    password: "fulco4991",
    email: "fulco94@gmail.com",
    name: "Fulco"
  )
  @x = User.find(@dummy.id)
  @x.persisted?
end

When("I click on go to my home feed") do
  click_button("Go to my Home Feed")
end

Then("I should see home page") do
  expect("localhost:3000/users")
end

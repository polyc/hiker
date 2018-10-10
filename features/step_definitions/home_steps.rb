Given("I am signed in as id={string}") do |string|
  @dummy1 = User.create!(
    id: 1,
    gender: "male",
    city: "Roma",
    surname: "Martinelli",
    nickname: "furcanne1234",
    password: "fulco4991",
    email: "fulco94@gmail.com",
    name: "Fulco1"
  )
  @dummy2 = User.create!(
    id: 2,
    gender: "male",
    city: "Roma",
    surname: "Martinelli",
    nickname: "fulco94",
    password: "fulco4991",
    email: "martinelli.fulco@gmail.com",
    name: "Fulco2"
  )

  #@dummy1.following << @dummy2
  @x = User.find(string.to_i)
  @x.persisted?
end


Given("I am on Hiker home page") do
  visit("localhost:3000/home")
end

Given("I have hikes on my home feed") do

end

Given("I am not banned by hike creator") do
  pending
end

Given("I am following hike's creator") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I click on the hike's creator name") do
  #click_link(page.find_link('//hikes/2').text)
  pending
end

Then("I should see the hike's creator profile id={string}") do |string|
  expect("localhost:3000/users/#{string}")
end

When("I click on more info") do

  @hike1 = Hike.create!(
    id: 1,
    name: "test1",
    route: "",
    difficulty: "P",
    rating: 3,
    tipo: "T",
    user_id: 2
  )
  @hike2 = Hike.create!(
    id: 2,
    name: "test2",
    route: "",
    difficulty: "P",
    rating: 3,
    tipo: "T",
    user_id: 2
  )
  Relationship.create(follower_id: @dummy1.id, followed_id: @dummy2.id)
  click_link(page.find_link("More info"))
end

Then("I should see {string} page") do |string|
  expect("localhost:3000/")
end

When("I click on add to favourites") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see a banner {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see a link remove hike from favourites") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("I have the hike in my favourite hikes") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I click on remove from favourites") do
  pending # Write code here that turns the phrase above into concrete actions
end

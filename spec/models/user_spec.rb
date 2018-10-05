require 'spec_helper'
require 'rails_helper'

describe User, :type => :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without name" do
    build(:user, name:  nil).should_not be_valid
  end

  it "is invalid if name length is more than 20" do
    build(:user, name:  "TROPPO LUNGO TROPPO LUNGO").should_not be_valid
  end

  it "is invalid if name length is less than 3" do
    build(:user, name:  "").should_not be_valid
  end

  it "is invalid without surname" do
    build(:user, surname:  nil).should_not be_valid
  end

  it "is invalid if surname length is more than 20" do
    build(:user, surname:  "TROPPO LUNGO TROPPO LUNGO").should_not be_valid
  end

  it "is invalid if surname length is less than 3" do
    build(:user, surname:  "").should_not be_valid
  end

  it "is invalid without nickname" do
    build(:user, nickname:  nil).should_not be_valid
  end

  it "is invalid if nickname length is more than 20" do
    build(:user, nickname:  "TROPPO LUNGO TROPPO LUNGO").should_not be_valid
  end

  it "is invalid if nickname length is less than 3" do
    build(:user, nickname:  "").should_not be_valid
  end

  it "has unique nickname" do
    create(:user)
    expect(build(:user, email:"baffo2@gmail.com")).not_to be_valid
  end

  it "is invalid without gender" do
    build(:user, gender:  nil).should_not be_valid
  end

  it "is invalid if gender not in (male female not-specified)" do
    build(:user, gender:  "alieno").should_not be_valid
  end

  it "is invalid without email" do
    build(:user, email:  nil).should_not be_valid
  end

  it "has unique email" do
    create(:user)
    expect(build(:user, nickname: "baffo2")).not_to be_valid
  end

  it "is invalid without city" do
    build(:user, city:  nil).should_not be_valid
  end

  it "is invalid with a fake city" do
    build(:user, city: "Paperopoli").should_not be_valid
  end

  it "checks if user inserted a real city" do
    user = build(:user)
    expect(user.check_city).to eq(true)
  end

  #it "checks if password matches" do
  #  user = build(:user, password: "mannaggia", password_confirmation: "mannaggia")
  #  expect(user.match_password("mannaggia")).to eq(user.password)
  #end

  it "discard plain text passwords after create" do
    user = build(:user, password: "mannaggia", password_confirmation: "mannaggia")
    user.clear_password
    expect(user.password).to eq(nil)
    expect(user.password_confirmation).to eq(nil)
  end

  #it "authenticates user" do
  #  user = build(:user)
  #  expect(User.authenticate("baffo","passwordacaso")).to eq(user)
  #end

  #it "creates user from facebook data" do
  #  user = build(:user)
  #  auth = { :provider => 'facebook', :uid => 1234, :info => { :email => user.email, :first_name => user.name, :last_name => user.surname, :name => user.name }}
  #  expect(User.from_omniauth(auth).persisted?).to eq(true)
  #end

  it"unfollow a user"do
    user1 = create(:user)
    user2 = create(:user, email: "prova@email.com", nickname: "baffo2")
    user1.following << user2
    build(:relationship, follower_id: user1.id, followed_id: user2.id)
    user1.unfollow(user2)
    expect(user1.following).to eq([])
  end

  it"checks if user follow another user"do
    user1 = create(:user)
    user2 = create(:user, email: "prova@email.com", nickname: "baffo2")
    user1.following << user2
    build(:relationship, follower_id: user1.id, followed_id: user2.id)
    expect(user1.following?(user2)).to eq(true)
  end

  it"unban a user"do
    user1 = create(:user)
    user2 = create(:user, email: "prova@email.com", nickname: "baffo2")
    user1.condemning << user2
    build(:ban, condemner_id: user1.id, banned_id: user2.id)
    user1.unban(user2)
    expect(user1.condemning).to eq([])
  end

  it"checks if user banned another user"do
    user1 = create(:user)
    user2 = create(:user, email: "prova@email.com", nickname: "baffo2")
    user1.condemning << user2
    build(:ban, condemner_id: user1.id, banned_id: user2.id)
    expect(user1.banned?(user2)).to eq(true)
  end
end

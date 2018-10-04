require 'spec_helper'
require 'rails_helper'

describe Relationship, :type => :model do
  it "has a valid factory" do
    user1 = create(:user)
    user2 = create(:user, email: "prova@email.com", nickname: "baffo2")
    expect(build(:relationship, follower_id: user1.id, followed_id: user2.id)).to be_valid
  end

  it "is invalid without follower" do
    user1 = create(:user)
    build(:relationship, follower_id: nil, followed_id: user1.id).should_not be_valid
  end

  it "is invalid without followed" do
    user1 = create(:user)
    build(:relationship, followed_id: nil, follower_id: user1.id).should_not be_valid
  end
end

require 'spec_helper'
require 'rails_helper'

describe Ban, :type => :model do
  it "has a valid factory" do
    user1 = create(:user)
    user2 = create(:user, email: "prova@email.com", nickname: "baffo2")
    expect(build(:ban, condemner_id: user1.id, banned_id: user2.id)).to be_valid
  end

  it "is invalid without condemner" do
    user1 = create(:user)
    build(:ban, condemner_id: nil, banned_id: user1.id).should_not be_valid
  end

  it "is invalid without banned" do
    user1 = create(:user)
    build(:ban, banned_id: nil, condemner_id: user1.id).should_not be_valid
  end
end

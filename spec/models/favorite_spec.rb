require 'spec_helper'
require 'rails_helper'

describe Favorite, :type => :model do
  it "has a valid factory" do
    author = create(:user)
    hike = create(:hike, user_id: author.id)
    expect(build(:favorite, favoritable_id: hike.id , user_id: author.id)).to be_valid
  end

  it "is invalid without favoritable type" do
    build(:favorite, favoritable_type:  nil).should_not be_valid
  end

  it "is invalid without user" do
    build(:favorite, user_id: nil).should_not be_valid
  end

  it "is invalid without favoritable" do
    build(:favorite, favoritable_id: nil).should_not be_valid
  end
end

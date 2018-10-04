require 'spec_helper'
require 'rails_helper'

describe User, :type => :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without name" do
    build(:user, name:  nil).should_not be_valid
  end

  it "is invalid without surname" do
    build(:user, surname:  nil).should_not be_valid
  end

  it "is invalid without nickname" do
    build(:user, nickname:  nil).should_not be_valid
  end

  it "is invalid without gender" do
    build(:user, gender:  nil).should_not be_valid
  end

  it "is invalid without email" do
    build(:user, email:  nil).should_not be_valid
  end

  it "is invalid without city" do
    build(:user, city:  nil).should_not be_valid
  end

  it "is invalid with a fake city" do
    build(:user, city: "Paperopoli").should_not be_valid
  end

end

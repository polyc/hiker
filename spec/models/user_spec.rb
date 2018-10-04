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
end

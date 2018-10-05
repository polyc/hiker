require 'spec_helper'
require 'rails_helper'

describe Hike, :type => :model do
  it "has a valid factory" do
    author = create(:user)
    expect(build(:hike, user_id: author.id)).to be_valid
  end

  it "is invalid without name" do
    build(:hike, name:  nil).should_not be_valid
  end

  it "is invalid if name length is more than 20" do
    build(:hike, name:  "TROPPO LUNGO TROPPO LUNGO").should_not be_valid
  end

  it "is invalid if name length is less than 1" do
    build(:hike, name:  "").should_not be_valid
  end

  it "is invalid without rating" do
    build(:hike, rating:  nil).should_not be_valid
  end

  it "is invalid if rating float is not like *.5 or *.0" do
    build(:hike, rating: "4.2").should_not be_valid
  end

  it "is invalid if rating not in [ 0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 ]" do
    build(:hike, rating: "7").should_not be_valid
  end

  it "is invalid without tipo" do
    build(:hike, tipo:  nil).should_not be_valid
  end

  it "is invalid with tipo not in [ T E EE EEA EAI ]" do
    build(:hike, tipo:  "scalata").should_not be_valid
  end

  it "is invalid without difficulty" do
    build(:hike, difficulty:  nil).should_not be_valid
  end

  it "is invalid without not in [ P, I, E ]" do
    build(:hike, difficulty:  "difficile").should_not be_valid
  end

  it "is invalid without author" do
    build(:hike, user_id:  nil).should_not be_valid
  end

  it "parse gpx file" do
    author = create(:user)
    hike = build(:hike, user_id: author.id)
    hike.filename = file_fixture("2018_09_13_15_53_10.gpx")
    expect(hike.parse_gpx.to_s).to eq(hike.route)
  end

  it "destroy gpx temp file" do
    author = create(:user)
    hike = build(:hike, user_id: author.id, filename: file_fixture("2018_09_13_15_53_10.gpx"))
    expect(hike.destroy_gpxfile).to eq(nil)
  end

  #it "is invalid if image is too big in data"do
  #  author = create(:user)
  #  hike = build(:hike, user_id: author.id)
  #  hike.hike_image = file_fixture("Toobig.jpg")
  #  expect(hike.image_size).to eq(false)
  #end
end

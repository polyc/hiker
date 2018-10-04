require 'spec_helper'

describe Comment, :type => :model do
  it "has a valid factory" do
    author = create(:user)
    hike = create(:hike, user_id: author.id)
    expect(build(:comment, comment:"sono un commento" , user_id: author.id, hike_id: hike.id)).to be_valid
  end

  it "is invalid without text" do
    build(:comment, comment:  nil).should_not be_valid
  end

  it "is invalid if comment length is more than 256" do
    build(:comment, comment: "Suo zio Talleyrand cercò una posizione alta per Edmond. Ciò non poteva avvenire in Francia, dal momento che Napoleone aveva vietato a tutte le ereditiere francesi di sposarsi al di fuori della nobiltà francese e poiché Talleyrand era caduto in disgrazia.qwerty").should_not be_valid
  end

  it "is invalid if comment length is less than 1" do
    build(:comment, comment: "").should_not be_valid
  end
end

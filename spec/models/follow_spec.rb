require "rails_helper"

RSpec.describe Follow, type: :model do
  before(:each) do
    @follow = Follow.new
  end

  describe "validations" do
    it "should have a user" do
      @follow.user = nil
      expect(@follow).to_not be_valid
    end

    it "should have a type_follow" do
      @follow.type_follow = nil
      expect(@follow).to_not be_valid
    end

    it "should have a follower_id" do
      @follow.follower_id = nil
      expect(@follow).to_not be_valid
    end
  end

  describe "associations" do
    it {should belong_to :user}
    it {should belong_to :follower}
  end
end

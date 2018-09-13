require "rails_helper"

RSpec.describe Comment, type: :model do
  before(:each) do
    @comment = Comment.new
  end

  describe "content validations" do
    it "should have a content" do
      @comment.content = nil
      expect(@comment).to_not be_valid
    end

    it "should allow content length between 1 and 255" do
      @comment.content = "a"
      expect(@comment).to eq @comment

      @comment.content = "a" * 255
      expect(@comment).to eq @comment
    end

    it "should not allow content longer than 255" do
      @comment.content = "a" * 256
      expect(@comment).to_not be_valid
    end
  end

  describe "associations" do
    it {should belong_to :user}
    it {should belong_to :book}
    it {should belong_to :parent}
    it {should have_many(:replies).dependent :destroy}
  end
end

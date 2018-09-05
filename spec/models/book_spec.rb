require "rails_helper"

RSpec.describe Book, type: :model do
  before(:each) do
    @book = Book.new
  end

  describe "validations" do
    describe "name validations" do
      it "should have a name" do
        @book.name = nil
        expect(@book).to_not be_valid
      end
    end

    describe "description validations" do
      it "should have a description" do
        @book.description = nil
        expect(@book).to_not be_valid
      end

      it "should allow description length between 1 and 255" do
        @book.description = "a"
        expect(@book).to eq @book

        @book.description = "a" * 255
        expect(@book).to eq @book
      end
    end

    describe "image validations" do
      it "should have a image" do
        @book.image = nil
        expect(@book).to_not be_valid
      end
    end

    describe "publish_date validations" do
      it "should have a publish_date" do
        @book.publish_date = nil
        expect(@book).to_not be_valid
      end
    end

    describe "price validations" do
      it "should have a price" do
        @book.price = nil
        expect(@book).to_not be_valid
      end
    end

    describe "category_id validations" do
      it "should have a category_id" do
        @book.category_id = nil
        expect(@book).to_not be_valid
      end
    end

    describe "associations" do
      it {should belong_to :category}
      it {should have_many(:comments).dependent :destroy}
      it {should have_many(:likes).dependent :destroy}
      it {should have_many(:mark_books).dependent :destroy}
      it {should have_many(:favorites).dependent :destroy}
      it {should have_many(:order_detail).dependent :destroy}
      it {should have_many(:author_books).dependent :destroy}
      it {should have_many(:authors).through :author_books}
      it {should have_many(:follows).dependent :destroy}
      it {should have_many(:passive_follows).dependent :destroy}
      it {should have_many(:follower_books).through :passive_follows}
      it {should accept_nested_attributes_for :author_books}
    end
  end
end

require "rails_helper"

RSpec.describe Category, type: :model do
  before(:each) do
    @category = Category.new
  end

  describe "validations" do
    describe "title validations" do
      it "should have a title" do
        @category.title = nil
        expect(@category).to_not be_valid
      end

      it "should allow title length between 1 and 255" do
        @category.title = "a"
        expect(@category).to eq @category

        @category.title = "a" * 255
        expect(@category).to eq @category
      end
    end

    describe "description validations" do
      it "should have a description" do
        @category.description = nil
        expect(@category).to_not be_valid
      end
    end
  end

  describe "scope" do
    context "with 2 or more category" do
      it "orders them in reverse chronologically" do
        category_1 = create(:category_1)
        category_2 = create(:category_2)
        expect(Category.list_category).to eq([category_2, category_1])
      end

      it "orders not them in reverse chronologically" do
        category_1 = create(:category_1)
        category_2 = create(:category_2)
        expect(Category.list_category).to_not eq([category_1, category_2])
      end
    end
  end
end

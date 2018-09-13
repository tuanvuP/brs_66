require "rails_helper"

RSpec.describe Author, type: :model do
  before(:each) do
    @author = Author.new
  end

  describe "validations" do
    describe "name validations" do
      it "should have a name" do
        @author.name = nil
        expect(@author).to_not be_valid
      end
    end

    describe "brith_year validations" do
      it "should have a brith_year" do
        @author.brith_year = nil
        expect(@author).to_not be_valid
      end
    end

    describe "country validations" do
      it "should have a country" do
        @author.country = nil
        expect(@author).to_not be_valid
      end
    end

    describe "biography validations" do
      it "should have a biography" do
        @author.biography = nil
        expect(@author).to_not be_valid
      end
    end
  end

  describe "associations" do
    it {should have_many(:author_books).dependent :destroy}
    it {should have_many(:books).through :author_books}
    it {should have_many(:follows).dependent :destroy}
    it {should have_many(:passive_follows).dependent :destroy}
    it {should have_many(:follower_authors).through :passive_follows}
  end

  describe "scope" do
    it "return a sorted array of result that match" do
      author1 = FactoryBot.create(:author1)
      author2 = FactoryBot.create(:author2)
      expect(Author.search("D")).to eq [author2]
      expect(Author.list_author).to eq([author2, author1])
    end
  end
end

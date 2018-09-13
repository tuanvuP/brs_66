require "rails_helper"

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new
  end

  describe "validations" do
    describe "username validations" do
      it "should have a username" do
        @user.username = nil
        expect(@user).to eq @user
      end

      it "should allow username length between 1 and 100" do
        @user.username = "a"
        expect(@user).to eq @user

        @user.username = "a" * 100
        expect(@user).to eq @user
      end

      it "should not allow username longer than 100" do
        @user.username = "a" * 101
        expect(@user).to eq @user
      end
    end

    describe "email validations" do
      it "should have an email" do
        @user.email = nil
        expect(@user).to_not be_valid
      end

      it "should allow email length between 5 and 100" do
        @user.email = "a@b.c"
        expect(@user).to eq @user

        @user.email = "a" * (100 - "@gmail.com".length) + "@gmail.com"
        expect(@user).to eq @user
      end

      it "should allow a valid email" do
        @user.email = "test_123@gmail.com"
        expect(@user).to eq @user
      end

      it "should not allow email longer than 100" do
        @user.email = "a" * (101 - "@gmail.com".length) + "@gmail.com"
        expect(@user).to eq @user
      end

      it "should not allow email without domain" do
        @user.email = "email"
        expect(@user).to_not be_valid
      end

      it "should not allow email with an invalid domain" do
        @user.email = "email@test."
        expect(@user).to eq @user
      end

      it "should not allow email with space" do
        @user.email = "e mail@test.com"
        expect(@user).to_not be_valid
      end

      it "should not allow email with special characters" do
        @user.email = "e#mail@test.com"
        expect(@user).to eq @user
      end
    end

    describe "password validations" do
      it "should have a password" do
        @user.password = nil
        expect(@user).to eq @user
      end

      it "should allow a valid password" do
        @user.password = "A123@a123"
        expect(@user).to eq @user
      end

      it "should not allow a too long password" do
        @user.password = "a" * 999
        expect(@user).to_not be_valid
      end

      it "should not allow password less than 6" do
        @user.password = "12345"
        expect(@user).to_not be_valid
      end
    end
  end

  describe "functions" do
    context ".follow" do
      it "should be able to follow other user" do
        other_user = User.new
        @user.follow other_user
        expect(@user.active_follows.find_by follower_id: other_user.id)
          .to eq other_user.id
      end
    end

    context ".unfollow" do
      it "should be able to unfollow other user" do
        other_user = User.new
        @user.follow other_user
        @user.unfollow other_user
        expect(@user.active_follows.find_by follower_id: other_user.id)
          .to be_nil
      end
    end

    context ".following?" do
      it "should be true if user is following the passed user" do
        other_user = User.new
        @user.follow other_user
        expect(@user.following? other_user).to be true
      end

      it "should be false if user is not following the passed user" do
        other_user = User.new
        expect(@user.following? other_user).to be false
      end
    end

    context ".favorite" do
      it "should be able to favorite book" do
        book = Book.new
        @user.favorite book
        expect(@user.favorited.find_by book_id: book.id).to eq book.id
      end
    end

    context ".favorited?" do
      it "should be true if user is favorited the passed user" do
        book = Book.new
        @user.favorite book
        expect(@user.favorited? book).to be true
      end

      it "should be false if user is not favorited the passed user" do
        book = Book.new
        expect(@user.favorited? book).to be false
      end
    end


    context ".like" do
      it "should be able to like book" do
        book = Book.new
        @user.like book
        expect(@user.liked.find_by book_id: book.id).to eq book.id
      end
    end

    context ".unlike" do
      it "should be able to unlike other user" do
        book = Book.new
        @user.like book
        @user.unlike book
        expect(@user.liked.find_by book: book.id).to be_nil
      end
    end

    context ".liked?" do
      it "should be true if user is liked book" do
        book = Book.new
        @user.like book
        expect(@user.liked? book).to be true
      end

      it "should be false if user is not liked book" do
        book = Book.new
        expect(@user.liked? book).to be false
      end
    end
  end

  describe "scope" do
    it "return a sorted array of result that match" do
      admin = FactoryBot.create(:admin)
      user1 = FactoryBot.create(:user1)
      user2 = FactoryBot.create(:user2)
      expect(User.search("U")).not_to include admin
    end
  end

  describe "associations" do
    it {should have_many(:comments).dependent :destroy}
    it {should have_many(:likes).dependent :destroy}
    it {should have_many(:mark_books).dependent :destroy}
    it {should have_many(:favorites).dependent :destroy}
    it {should have_many(:orders).dependent :destroy}
    it {should have_many(:follows).dependent :destroy}
    it {should have_many(:liked).through :likes}
    it {should have_many(:favorited).through :favorites}
    it {should have_many(:active_follows).dependent :destroy}
    it {should have_many(:passive_follows).dependent :destroy}
    it {should have_many(:followers).through :passive_follows}
    it {should have_many(:following).through :active_follows}
    it {should have_many(:following_author).through :active_follows}
    it {should have_many(:following_book).through :active_follows}
  end
end

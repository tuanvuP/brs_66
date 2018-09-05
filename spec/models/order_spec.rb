require "rails_helper"

RSpec.describe Order, type: :model do
  before(:each) do
    @order = Order.new
  end

  describe "validations" do
    it "should have a full_name" do
      @order.full_name = nil
      expect(@order).to_not be_valid
    end

    it "should have a phone" do
      @order.phone = nil
      expect(@order).to_not be_valid
    end

    it "should have a address" do
      @order.address = nil
      expect(@order).to_not be_valid
    end
  end

  describe "associations" do
    it {should belong_to :user}
    it {should have_many :order_details}
    it {should have_many(:books).through :order_details}
  end
end

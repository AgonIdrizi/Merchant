require 'rails_helper'

RSpec.describe Product, type: :model do

  it "is an instance of Product" do
    product = FactoryGirl.build(:product)
    product.save
    expect(product).to be_an_instance_of(Product)
  end

  describe "validating title" do
  	context "without title" do
  	  it "is not valid without title" do
  	  	product = FactoryGirl.build(:product, title: '')
  	  	product.valid?
  	  	expect(product.errors[:title]).to include("can't be blank")
  	  end
  	end
  	context 'with title'do
  	  it "is valid with title" do
  	  	product = FactoryGirl.build(:product)
  	  	product.save
  	  	expect(product.persisted?).to be_truthy
  	  end
  	end
  end

  describe "validating price" do
  	context "is not valid with different attribute types" do
  	  it "is not valid with string" do
  	  	product = FactoryGirl.build(:product,price: "esss")
  	  	product.save
  	  	puts "#{product.inspect}"
  	  	expect(product.persisted?).to be_falsey
  	  end
  	  it "is not valid with negative values" do
  	  	product = FactoryGirl.build(:product,price: -1)
  	  	product.save
  	  	expect(product.errors[:price]).to include("must be greater than 0.0")
  	  end

  	  it "is not valid with 0" do
  	  	product = FactoryGirl.build(:product,price: 0)
  	  	product.save
  	  	expect(product.errors[:price]).to include("must be greater than 0.0")
  	  end

  	  it "is not valid with number greater than 9999999" do
  	  	product = FactoryGirl.build(:product,price: 1000000000)
  	  	product.save
  	  	expect(product.errors[:price]).to include("must be less than 1000000.0")
  	  end
  	end

  	context "is valid with" do
  	  it "is valid with number" do
  	  	product = FactoryGirl.build(:product)
  	  	product.save
  	  	puts "#{product.inspect}"
  	  	expect(product.persisted?).to be_truthy
  	  end

  	  it "is valid with number" do
  	  	product = FactoryGirl.build(:product, price: 3)
  	  	product.save
  	  	puts "#{product.inspect}"
  	  	expect(product.persisted?).to be_truthy
  	  end
    end
  end
end

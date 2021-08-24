require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      category = Category.create(name: 'Toy')
      productParams = {
        name: "Example",
        description: "This is an example",
        category_id: category.id,
        quantity: 10,
        price: 15
      }
      product = Product.new(productParams)
      expect(product).to be_valid
    end
    it "should error with message Name can't be blank " do
      category = Category.create(name: 'Toy')
      productParams = {
        name: nil,
        category_id: category.id,
        quantity: 10,
        price: 15
      }
      product = Product.new(productParams)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq(["Name can't be blank"])
    end
    it "should error with message Category can't be blank " do
      category = Category.create(name: 'Toy')
      productParams = {
        name: 'Example',
        category_id: nil,
        quantity: 10,
        price: 15
      }
      product = Product.new(productParams)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq(["Category can't be blank"])
    end
    it "should error with message Quantity can't be blank " do
      category = Category.create(name: 'Toy')
      productParams = {
        name: 'Example',
        category_id: category.id,
        quantity: nil,
        price: 15
      }
      product = Product.new(productParams)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq(["Quantity can't be blank"])
    end
    it "should error with message Price can't be blank " do
      category = Category.create(name: 'Toy')
      productParams = {
        name: 'Example',
        category_id: category.id,
        quantity: 10,
        price: nil
      }
      product = Product.new(productParams)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
  end
end

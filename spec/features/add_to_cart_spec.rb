require 'rails_helper'

RSpec.feature "Visitor add a product to cart", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price:64.99
      )
    end
  end

  scenario "Click on add to cart on a product, cart content increase from 0 to 1" do
    visit root_path
    page.all('article', class: 'product').sample.click_button('Add')
    expect(page.find("nav")).to have_text ' My Cart (1) '
  end
end

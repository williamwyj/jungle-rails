require 'rails_helper'

RSpec.feature "Visitor navigate from the home page to the product detail", type: :feature, js: true do
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

  scenario "Click on a product partial and navigate to a product detail page" do
    visit root_path
    page.all('article', class: 'product').sample.click_on('Details »')
    expect(page).to have_css 'section.products-show', visible: true
  end
end

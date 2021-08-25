require 'rails_helper'

RSpec.feature "User Login", type: :feature, js: true do
  before :each do
    
    User.create!(
      first_name: "Archie",
      last_name: "Cohen",
      email: "example@email.com",
      password: "12345",
      password_confirmation: "12345",
    )
    
  end

  scenario "Navigate to the root page/product index and click login to go the login page" do
    visit root_path
    page.find('nav').click_on('Login')
    expect(page.find('main.container')).to have_field("password")
  end

  scenario "Navigate to the login page, login with credential and redirect to products logged in" do
    visit root_path
    page.find('nav').click_on('Login')
    fill_in 'email', with: "example@email.com"
    fill_in 'password', with: "12345"
    click_button("Submit")
    save_screenshot
    expect(page.find('nav')).to have_text("Logout")
  end

  scenario "Navigate to the login page, login with email in uppercase and redirect to products logged in" do
    visit root_path
    page.find('nav').click_on('Login')
    fill_in 'email', with: "exampLE@email.com"
    fill_in 'password', with: "12345"
    click_button("Submit")
    save_screenshot
    expect(page.find('nav')).to have_text("Logout")
  end

  scenario "Navigate to the login page, login wrong email and stay in login page" do
    visit root_path
    page.find('nav').click_on('Login')
    fill_in 'email', with: "wrong@email.com"
    fill_in 'password', with: "12345"
    click_button("Submit")
    save_screenshot
    expect(page.find('main.container')).to have_field("password")
  end
end


require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "must be created with a password and password_confirmation fields" do
      userParams = {
        first_name: "Archie",
        last_name: "Cohen",
        email: "example@email.com",
        password: "12345",
        password_confirmation: "12345"
      }
      user = User.new(userParams)
      expect(user).to be_valid
    end

    it "will error if password and password_confirmation fields does not match" do
      userParams = {
        first_name: "Archie",
        last_name: "Cohen",
        email: "example@email.com",
        password: "12345",
        password_confirmation: "54321"
      }
      user = User.new(userParams)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "will error if password and password_confirmation fields are blank" do
      userParams = {
        first_name: "Archie",
        last_name: "Cohen",
        email: "example@email.com",
        password: nil,
        password_confirmation: nil
      }
      user = User.new(userParams)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it "will error if email is duplicate, and not unique" do
      userParams = {
        first_name: "Archie",
        last_name: "Cohen",
        email: "example@email.com",
        password: "123",
        password_confirmation: "123"
      }
      userTwoParams = {
        first_name: "Amy",
        last_name: "Mansell",
        email: "examplE@email.com",
        password: "321",
        password_confirmation: "321"
      }
      user = User.create(userParams)
      userTwo = User.create(userTwoParams)
      expect(userTwo).to_not be_valid
      expect(userTwo.errors.full_messages).to include("Email has already been taken")
    end
    it "will error if email is blank" do
      userParams = {
        first_name: "Archie",
        last_name: "Cohen",
        email: nil,
        password: "123",
        password_confirmation: "123"
      }
      user = User.new(userParams)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it "will error if first_name is blank" do
      userParams = {
        first_name: nil,
        last_name: "Cohen",
        email: "test@test.com",
        password: "123",
        password_confirmation: "123"
      }
      user = User.new(userParams)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end
    it "will error if last_name is blank" do
      userParams = {
        first_name: "Archie",
        last_name: nil,
        email: "test@test.com",
        password: "123",
        password_confirmation: "123"
      }
      user = User.new(userParams)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it "will error if password is shorter than 3 characters" do
      userParams = {
        first_name: "Archie",
        last_name: "Cohen",
        email: "test@test.com",
        password: "12",
        password_confirmation: "12"
      }
      user = User.new(userParams)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
  end
  describe '.authenticate_with_credentials' do
    it 'should return a valid user if authenticated' do
      userParams = {
        first_name: "Archie",
        last_name: "Cohen",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      }
      user = User.create(userParams)
      login_me = User.authenticate_with_credentials(user.email, user.password)
      expect(login_me).to be_valid
    end

    it 'should return nil if password is wrong' do
      userParams = {
        first_name: "Archie",
        last_name: "Cohen",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      }
      user = User.create(userParams)
      login_me = User.authenticate_with_credentials(user.email, "000")
      expect(login_me).to be_nil
    end

    it 'should return a valid user if email has space infront or trailing' do
      userParams = {
        first_name: "Archie",
        last_name: "Cohen",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      }
      user = User.create(userParams)
      login_me = User.authenticate_with_credentials("  test@test.com", user.password)
      expect(login_me).to be_valid
    end

    it 'should return a valid user if email does not have correct letter case' do
      userParams = {
        first_name: "Archie",
        last_name: "Cohen",
        email: "eXample@domain.com",
        password: "1234",
        password_confirmation: "1234"
      }
      user = User.create(userParams)
      login_me = User.authenticate_with_credentials("EXAMPLe@DOMAIN.com", user.password)
      expect(login_me).to be_valid
    end
  end
end

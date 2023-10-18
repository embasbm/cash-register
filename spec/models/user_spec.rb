require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a password" do
    user = build(:user, password: nil)
    expect(user).to_not be_valid
  end

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is database authenticatable" do
    user = create(:user, email: 'test@example.com', password: 'password123')
    expect(user.valid_password?('password123')).to be true
    expect(user.valid_password?('wrong_password')).to be false
  end

  it "is registerable" do
    user = create(:user)
    expect(user).to be_persisted
  end

  it "is recoverable" do
    user = create(:user)
    user.send_reset_password_instructions
    expect(user.reset_password_token).to be_present
  end

  it "is rememberable" do
    user = create(:user)
    user.remember_me!
    expect(user.remember_created_at).to be_present
  end

  it "is validatable" do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'has one cart' do
    user = User.reflect_on_association(:cart)
    expect(user.macro).to eq(:has_one)
  end
end

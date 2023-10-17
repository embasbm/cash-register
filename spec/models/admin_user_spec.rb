require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it "is valid with valid attributes" do
    admin_user = build(:admin_user)
    expect(admin_user).to be_valid
  end

  it "is not valid without an email" do
    admin_user = build(:admin_user, email: nil)
    expect(admin_user).to_not be_valid
  end

  it "is not valid without a password" do
    admin_user = build(:admin_user, password: nil)
    expect(admin_user).to_not be_valid
  end

  it "has a valid factory" do
    expect(build(:admin_user)).to be_valid
  end

  it "is database authenticatable" do
    admin_user = create(:admin_user, email: 'test@example.com', password: 'password123')
    expect(admin_user.valid_password?('password123')).to be true
    expect(admin_user.valid_password?('wrong_password')).to be false
  end

  it "is registerable" do
    admin_user = create(:admin_user)
    expect(admin_user).to be_persisted
  end

  it "is recoverable" do
    admin_user = create(:admin_user)
    admin_user.send_reset_password_instructions
    expect(admin_user.reset_password_token).to be_present
  end

  it "is rememberable" do
    admin_user = create(:admin_user)
    admin_user.remember_me!
    expect(admin_user.remember_created_at).to be_present
  end

  it "is validatable" do
    admin_user = build(:admin_user)
    expect(admin_user).to be_valid
  end
end

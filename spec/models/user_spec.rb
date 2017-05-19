require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be valid' do
    user = create(:user)
    expect(user).to be_valid
  end
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:email).is_at_most(255) }
  it { should validate_length_of(:name).is_at_most(50) }
  it 'email validation should reject invalid addresses' do
    user = build(:user)
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      user.valid?
      expect(user.errors[:email]).to include('is invalid')
    end
  end
  it 'email addresses should be unique' do
    user = build(:user)
    create(:user, email: user.email.upcase)
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end
  it 'email addresses should be saved as lower-case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    user = create(:user, email: mixed_case_email)
    expect(mixed_case_email.downcase).to eq(user.email)
  end
  it { should validate_length_of(:password).is_at_least(6) }
  it 'password should be present (nonblank)' do
    user = build(:user)
    user.password = user.password_confirmation = ' ' * 6
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
end

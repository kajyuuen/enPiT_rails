require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'should be valid' do
    expect(user).to be_valid
  end
  describe 'email' do
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_most(255) }
    it 'should reject invalid addresses' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        user.valid?
        expect(user.errors[:email]).to include('is invalid')
      end
    end
    it 'should be unique' do
      create(:user, email: user.email.upcase)
      user.valid?
      expect(user.errors[:email]).to include('has already been taken')
    end
    it 'should be saved as lower-case' do
      mixed_case_email = 'Foo@ExAMPle.CoM'
      user = create(:user, email: mixed_case_email)
      expect(mixed_case_email.downcase).to eq(user.email)
    end
  end
  describe 'name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end
  describe 'password' do
    it { should validate_length_of(:password).is_at_least(6) }
    it 'should be present (nonblank)' do
      user.password = user.password_confirmation = ' ' * 6
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  end
end

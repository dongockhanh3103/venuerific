require 'rails_helper'

describe User do
  it 'is database authenticable' do
    user = described_class.create(
      email: 'admin@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    expect(user.valid_password?('password123')).to be_truthy
  end
end

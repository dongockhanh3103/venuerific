require 'rails_helper'

describe Post do
  let!(:user) { create(:user) }

  it 'create post successfully' do
    post = described_class.new
    post.title = 'New Post'
    fake_content = Faker::Lorem.paragraph_by_chars(number: 1500)
    post.content = fake_content
    post.user = user
    post.save!

    expect(post).to be_present
    expect(post.title).to eq('New Post')
    expect(post.content.to_plain_text).to eq(fake_content)
    expect(post.user_id).to eq(user.id)
    expect(post.truncated_content).to eq(fake_content.truncate_words(50))
  end
end

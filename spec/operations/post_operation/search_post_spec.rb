require 'rails_helper'

describe PostOperation::SearchPost do
  let!(:regular_user) { create(:user) }
  let!(:first_posts)  { create_list(:post, 5, user: regular_user, title: 'first_post') }
  let!(:second_posts) { create_list(:post, 10, user: regular_user, title: 'second_post') }
  let!(:first_params) do
    {
      keyword: 'first_post',
      page:    1
    }
  end
  let!(:second_params) do
    {
      keyword: 'second_post',
      page:    1
    }
  end

  context 'when get search result successfully' do
    it 'with first_post keyword' do
      result = described_class.execute(first_params)

      expect(result).to be_present
      expect(result.size).to eq(5)
    end

    it 'with second_post keyword' do
      result = described_class.execute(second_params)

      expect(result).to be_present
      expect(result.size).to eq(10)
    end
  end
end

require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe 'model validation' do
    context 'without correct attributes' do
      it 'with url is too short' do
        invalid_url = described_class.new
        expect(invalid_url).not_to be_valid
        expect(invalid_url.errors[:original_url]).to include("is too short (minimum is 5 characters)")
        expect(invalid_url.save).to eq(false)
      end

      context 'with url.length > 255' do
        let!(:url) { (0...256).map { ('a'..'z').to_a[rand(26)] }.join }

        it 'is too long' do
          invalid_category = described_class.new(original_url: url)
          expect(invalid_category).not_to be_valid
          expect(invalid_category.errors[:original_url]).to include('is too long (maximum is 255 characters)')
          expect(invalid_category.save).to eq(false)
        end
      end

      context 'with url invalid format' do
        let!(:url) { 'dummy' }

        it 'is invalid' do
          invalid_category = described_class.new(original_url: url)
          expect(invalid_category).not_to be_valid
          expect(invalid_category.errors[:original_url]).to include('is invalid')
          expect(invalid_category.save).to eq(false)
        end
      end
    end
  end

  describe 'get_short_url' do
    let!(:url) { "https://www.google.com/maps/dir/49.0506223,8.3846022/mahatma+gandhi+nagar+extension+vallam/@24.5174651,6.263056,3z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x3baabf5c6d6e6829:0x452d2b246aef4584!2m2!1d79.0679439!2d10.7137201" }
      it 'generates url' do
        valid_rl = described_class.get_short_url(url)
        expect(valid_rl.length).to be(6)
      end
  end
end


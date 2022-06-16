class ShortUrl < ApplicationRecord
  MAX_RETRIES = 5

  validates :original_url,
            format: URI::regexp(%w[http https]),
            uniqueness:  { message: "Url Generation Error, retry later" },
            length: {within: 5..255}

  before_validation :set_shorted_url

  def set_shorted_url
    self.shorted_url = generate
  end

  def generate
    retry_attempts = 0
    loop do
      if retry_attempts <= MAX_RETRIES
        retry_attempts += 1
        url = SecureRandom.uuid[0..5]
        break url unless ShortUrl.where(shorted_url: url).exists?
      else
        self.errors.add(:base, "Url generation failed, retry after sometime")
        break
      end
    end
  end

  class << self
    def get_short_url(url)
      short = where(original_url: url).first
      return short.shorted_url if short
      short = new(original_url: url)
      return short.shorted_url if short.save
      return short
    end
  end

  private :set_shorted_url, :generate
end


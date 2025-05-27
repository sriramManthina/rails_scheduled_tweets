class TwitterAccount < ApplicationRecord
  has_many :tweets
  belongs_to :user
  validates :username, presence: true, uniqueness: true

  # def client
  #   Twitter::REST::Client.new do |config|
  #     config.consumer_key = Rails.application.credentials.dig(:twitter, :api_key)
  #     config.consumer_secret = Rails.application.credentials.dig(:twitter, :api_secret)
  #     config.access_token = token
  #     config.access_token_secret = secret
  #   end
  # end

  def client
    x_credentials = {
      api_key: Rails.application.credentials.dig(:twitter, :api_key),
      api_key_secret: Rails.application.credentials.dig(:twitter, :api_secret),
      access_token: token,
      access_token_secret: secret
    }

    X::Client.new(**x_credentials)
  end
end


# Rails.application.credentials.dig(:twitter, :api_key), Rails.application.credentials.dig(:twitter, :api_secret)
class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true

  after_initialize do
    self.publish_at ||= 24.hours.from_now
  end

  def published?
    tweet_id?
  end

  # can run > Tweet.last.publish_to_twitter! in console to publish the last tweet
  def publish_to_twitter!
    data = {text: body }
    tweet = twitter_account.client.post("tweets", data.to_json) do |req|
      req.headers['Content-Type'] = 'application/json'
    end
    update(tweet_id: tweet["data"]["id"])
  end
end

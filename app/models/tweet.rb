class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true

  after_initialize do
    self.publish_at ||= 24.hours.from_now
  end

  # called after something is saved into the DB
  after_save_commit do
    if publish_at_previous_changed?
      # creates the job for publishing the tweet
      TweetJob.set(wait_until: publish_at).perform_later(self)
    end
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

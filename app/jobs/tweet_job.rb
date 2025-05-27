class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    # (posting earlier than original time)
    return if tweet.published?

    # Rescheduled a tweet to the future (posting later than original time)
    return if tweet.publish_at > Time.current

    tweet.publish_to_twitter!
  end
end


# Push the publish_at forward in time (posting earlier than original time)
# noon -> 8am
# -
# 8am -> sets tweet id
# noon -> published already, hence doest nothing

# Push the publish_at with delay (posting later than original time)
# 9am -> 1pm
# -
# 9am -> should do nothing
# 1pm -> should publish the tweet and set the tweet_id

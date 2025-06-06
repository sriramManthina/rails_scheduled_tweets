class OmniauthCallbacksController < ApplicationController
  def twitter
    # Rails.logger.info auth
    twitter_account = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
    twitter_account.update(
      name: auth.info.name,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
    )

    redirect_to twitter_accounts_path, notice: "Successfully logged in. #{auth.info.nickname} - #{auth.info.name}"
  end

  def auth
    request.env['omniauth.auth']
  end
end
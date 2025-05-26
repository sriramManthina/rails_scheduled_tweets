class TwitterAccountsController < ApplicationController
  before_action :require_user_logged_in!
  def index
    @twitter_accounts = Current.user.twitter_accounts
  end

  def destroy
    @twitter_account = Current.user.twitter_accounts.find(params[:id])
    @twitter_account.destroy
    # even though in the above line @twitter_account has been deleted, it will still be in the memory until the action is complete
    # hence we are using it in the below line
    redirect_to twitter_accounts_path, notice: "Successfully disconnected @#{@twitter_account.username}"
  end
end
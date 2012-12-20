class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(resource)
    feed_entries_path
  end

  unless config.consider_all_requests_local
    rescue_from Exception, :with => :render_404
  end

  private

  def render_404
    flash[:error] = 'The url you tried to access seems incorrect'
    redirect_to home_path
  end
end

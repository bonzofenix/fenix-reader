class FeedsController < ApplicationController
  def index
  end

  def subscribe
    unless current_user.add_channel(params[:url])
      flash[:error] = 'Can not subscribe to this url. Verify that is a valid rss/atom service'
    end

    render :index
  end
end

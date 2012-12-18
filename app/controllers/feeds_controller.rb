class FeedsController < ApplicationController
  def index
  end

  def subscribe
    current_user.add_channel(params[:url])
  end
end

class ChannelsController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :index, :edit, :destroy, :update

  protected
  def begin_of_association_chain
    current_user
  end
end

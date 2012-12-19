class ChannelsController < InheritedResources::Base
  actions :index, :edit, :destroy, :update
  protected
  def begin_of_association_chain
    current_user
  end
end

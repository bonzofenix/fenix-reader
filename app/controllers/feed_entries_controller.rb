class FeedEntriesController <  InheritedResources::Base
  actions :index, :edit, :update
  has_scope :starred, :type => :boolean
  has_scope :summary
  has_scope :title

  def update
    update! do |format|
      format.js { render nothing: true }
    end
  end

  def subscribe
    unless current_user.add_channel(params[:url])
      flash[:error] = 'Can not subscribe to this url. Verify that is a valid rss/atom service'
    end
    render :index
  end

  protected
  def begin_of_association_chain
    current_user
  end
end


class CommentsController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :create
  belongs_to :feed_entry

  def create
    create! do |format|
      format.js { render nothing: true }
    end
  end
end

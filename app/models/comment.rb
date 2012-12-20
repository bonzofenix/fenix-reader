class Comment < ActiveRecord::Base
  belongs_to :feed_entry
  attr_accessible :text
end

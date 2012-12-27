class FeedEntry < ActiveRecord::Base
  belongs_to :channel
  has_many :comments
  scope :starred, where( 'stars <> 0' )
  scope :summary, proc { |summary| where(['summary LIKE ?', "%#{summary}%"]) }
  scope :title, proc { |title| where(['title LIKE ?', "%#{title}%"]) }
  default_scope order('published_at DESC')

  attr_accessible :guid, :published_at, :summary, :title, :url, :channel_id, :stars
end

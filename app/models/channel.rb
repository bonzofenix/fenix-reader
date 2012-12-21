class Channel < ActiveRecord::Base
  has_many :feed_entries
  belongs_to :user
  before_save :check_url
  before_save :check_user_space
  before_save :set_title

  attr_accessible :url

  # IF feedzirra finds a parser for the xml that the url returned then the 
  # URL is fine.
  def check_url
    xml = get_response(url)
    parser = Feedzirra::Feed.determine_feed_parser_for_xml(xml)
    !parser.nil?
  end
    
  def set_title
    xml = get_response(url)
    feed = Feedzirra::Feed.parse(xml)
    self.title ||= feed.title
  end
  
  def check_user_space
    user.channels.count < user.max_channels
  end
    
  def get_response(url)
    @xml ||= Net::HTTP.get_response(URI.parse(url)).body
  end
  
  def self.update_feeds
    all.each {|c| FeedEntry.update_from_feed(c) }
  end
end

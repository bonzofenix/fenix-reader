class Channel < ActiveRecord::Base
  has_many :feed_entries
  belongs_to :user
  before_save :check_url
  before_save :check_user_space
  before_save :set_title
  after_create :update_feeds
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
    
  def update_feeds
    feed = get_parsed_feed
    add_entries(feed.entries) if feed.respond_to? :entries
  end

  def get_response(url)
    @xml ||= Net::HTTP.get_response(URI.parse(url)).body
  end
  

  def get_parsed_feed
    Feedzirra::Feed.fetch_and_parse(url)
  end

  def self.update_feeds
    all.each {|c| c.update_feeds }
  end

  def add_entries(entries)
    entries.each do |entry|
      unless feed_entries.exists? guid: entry.id
        feed_entries.create!( title: entry.title, summary: entry.summary, url: entry.url,
          published_at: entry.published, guid: entry.id)
      end
    end
  end
end

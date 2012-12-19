class FeedEntry < ActiveRecord::Base
  belongs_to :channel
  attr_accessible :guid, :published_at, :summary, :title, :url, :channel_id

 def self.update_from_feed(channel)
    feed = get_parsed_feed(channel) 
    debugger
    add_entries(feed.entries, channel)
  end
  
  private 

  # Had a problem when stubbing feedzirra method so as it was takeing too
  # much time I decided to create a private method. not that uglt anyway.
  def self.get_parsed_feed(channel)
    Feedzirra::Feed.fetch_and_parse(channel.url)
  end
 
  def self.add_entries(entries, channel)
    entries.each do |entry|
      unless exists? guid: entry.id
        create!( title: entry.title, summary: entry.summary, url: entry.url,
          published_at: entry.published, guid: entry.id, channel_id: channel.id)
      end
    end
  end
end

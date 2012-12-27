require 'spec_helper'

describe FeedEntry do
  let(:feed){ create :feed_entry }
  let(:other_feed){ create :feed_entry }
  let(:feedzirra_feed) do
    # mocks feedzirra rss entries response
    @feed = Feedzirra::Parser::RSS.new
    @entry = Feedzirra::Parser::RSSEntry.new.tap do |e|
      e.title = 'title'
      e.summary = 'this is a summary'
      e.url = 'www.rss.com'
      e.published = Time.now
      e.entry_id = 'guid'
    end
    
    @feed.entries = [ @entry ]
    @feed
  end

  before :each do
    Channel.any_instance.stub(check_url: true) 
    Channel.any_instance.stub(set_title: true) 
  end
  
  it 'orders feed by publizhed at desc' do
    feed.update_attribute(:published_at, Date.today - 1.day )
    other_feed.update_attribute(:published_at, Date.today )
    FeedEntry.all.should == [ other_feed, feed]
  end
  
  describe 'when adding entry' do
    it 'adds the entry' do
      FeedEntry.stub(get_parsed_feed: feedzirra_feed)
      expect do 
        FeedEntry.update_from_feed(channel) 
      end.to change{ FeedEntry.count }.by(1)
    end

    it 'the entry belongs to the channel' do
      FeedEntry.update_from_feed(channel) 
      FeedEntry.last.channel.should == channel
    end
  end
  
  it 'return stared feeds' do
    feed
    other_feed.update_attribute(:stars, 3)
    FeedEntry.starred.count.should == 1
    FeedEntry.all.count.should == 2
  end
end

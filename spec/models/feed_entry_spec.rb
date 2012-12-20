require 'spec_helper'

describe FeedEntry do
  let(:channel){ create :channel, :with_user }
  let(:feed){ create :feed_entry, channel: channel }
  let(:other_feed){ create :feed_entry, channel: channel }


  before :each do
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

    FeedEntry.stub(get_parsed_feed: @feed)
    Channel.any_instance.stub(check_url: true) 
  end

  
  describe 'when adding entry' do
    it 'adds the entry' do
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
    FeedEntry.stared.count.should == 1
    FeedEntry.all.count.should == 2
  end
end

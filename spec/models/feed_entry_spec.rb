require 'spec_helper'

describe FeedEntry do
  let(:feed){ create :feed_entry }
  let(:other_feed){ create :feed_entry }

  it 'orders feed by publizhed at desc' do
    feed.update_attribute(:published_at, Date.today - 1.day )
    other_feed.update_attribute(:published_at, Date.today )
    FeedEntry.all.should == [ other_feed, feed]
  end
 
  it 'return stared feeds' do
    feed
    other_feed.update_attribute(:stars, 3)
    FeedEntry.starred.count.should == 1
    FeedEntry.all.count.should == 2
  end
end

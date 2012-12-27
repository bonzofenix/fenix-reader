require 'spec_helper'

describe Channel do
  let(:user){ create :user }
  let(:channel){ build :channel, user: user }
  let(:old_channel){ create(:channel, user: user) }
  let(:atom_xml){ get_xml(:atom) }
  let(:rss_xml){ get_xml(:rss) }

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
    Channel.any_instance.stub(:get_response).and_return( atom_xml )
  end

  it 'when updateing feeds adds an entry' do
    old_channel.stub(get_parsed_feed: feedzirra_feed)
    expect do 
      old_channel.update_feeds
    end.to change{ old_channel.reload.feed_entries.count }.by(1)
  end

  it 'after create update feeds if its a new record' do
    channel.should_receive :update_feeds
    channel.save
  end

  describe 'before saving' do
    it 'call check_url' do   
      channel.should_receive :check_url
      channel.save
    end
    
    it 'sets the title' do
      channel.should_receive :set_title
      channel.save
    end


    it 'checks that it can connect to the channel' do
      Channel.any_instance.stub(get_response:  '')
      channel.save
      channel.should_not be_persisted
    end

    it 'does not overwrite the title if it was change or already exists' do
      old_channel = create :channel, user: user, title: 'custom title'
      old_channel.save 
      old_channel.title.should_not == 'My Simple Feed'
    end

    it 'adds the title of the channel if possible' do
      channel.save 
      channel.title.should == 'My Simple Feed'
    end

    it 'checks rss channels' do
      Channel.any_instance.stub(:get_response).and_return( rss_xml )
      channel.save 
      channel.should be_persisted
    end

    it 'checks atom channel' do
      channel.save 
      channel.should be_persisted
    end
  end
end


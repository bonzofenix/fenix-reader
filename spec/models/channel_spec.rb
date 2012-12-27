require 'spec_helper'

describe Channel do
  let(:user){ create :user }
  let(:channel){ build :channel, user: user }
  let(:atom_xml){ get_xml(:atom) }
  let(:rss_xml){ get_xml(:rss) }
  let(:old_channel){ create(:channel, user: user) }

  before :each do
    Channel.any_instance.stub(:get_response).and_return( atom_xml )
    FeedEntry.stub(:update_from_feed)
  end


  describe 'after create' do
    it 'update feeds if its a new record' do
      channel.should_receive :update_feeds
      channel.save
    end

    it 'does not update feeds if it is an old record' do
     old_channel.should_not_receive :update_feeds
      old_channel.save
    end
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

    it 'does not overwrite the title if it was changed or exits' do
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


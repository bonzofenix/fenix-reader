require 'spec_helper'

describe User do
  let(:user){ create :user }
  before(:each) do
    Channel.any_instance.stub(check_url: true) 
    Channel.any_instance.stub(set_title: true) 
    FeedEntry.stub(:update_from_feed)
  end
  
  [:twitter, :google_oauth2].each do |service|
    describe "when creating #{service} users" do
      it 'authenticated user' do
        expect do
          User.send("find_for_#{service}", OmniAuth.config.mock_auth[service])
        end.to change{ User.count }
      end
      
      it 'skips the confirmation' do
        user =User.send("find_for_#{service}", OmniAuth.config.mock_auth[service])
        user.should be_confirmed
      end
    end
  end

  describe 'when adding channels' do
    it 'creates the channel if the url response 200' do
      expect do
        user.add_channel('www.rss_valid_url.com')
      end.to change{ Channel.count }
    end

    it 'creates the channel if the url is a rss/atom' do
    end

    it 'can not add a channel if there istnt enough space' do
      user.update_attribute(:max_channels, 1)

      expect do
        user.add_channel('www.rss_valid_url1.com')
        user.add_channel('www.rss_valid_urli2.com')
      end.to change{ Channel.count }.by(1)
    end
  end
end

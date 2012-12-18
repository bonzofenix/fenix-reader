require 'spec_helper'

describe User do
  let(:user){ create :user }
  describe 'when creating twitter users' do
    it 'authenticated user' do
      expect do
        User.find_for_twitter OmniAuth.config.mock_auth[:twitter]
      end.to change{ User.count }
    end
    
    it 'skips the confirmation' do
      user = User.find_for_twitter OmniAuth.config.mock_auth[:twitter]
      user.should be_confirmed
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
      user.max_channels = 1
      expect do
        user.add_channel('www.rss_valid_url1.com')
        user.add_channel('www.rss_valid_urli2.com')
      end.to change{ Channel.count }.by(1)
    end
  end
end

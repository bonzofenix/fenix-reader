require 'spec_helper'

describe User do
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
end

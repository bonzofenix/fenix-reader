require 'spec_helper'

describe Users::OmniauthCallbacksController do
  describe 'when authorizing a twitter account' do
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
    end
    
    it 'signs up using twitter' do
      get :twitter
      controller.user_signed_in?.should be_true
    end
  end
end

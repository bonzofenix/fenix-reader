require 'spec_helper'

describe Users::OmniauthCallbacksController do
  describe 'when authorizing a twitter account' do
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end
    
    [:twitter, :google_oauth2].each do |provider|
      it "signs up using #{provider}" do
        @request.env['omniauth.auth'] = OmniAuth.config.mock_auth[provider]
        get provider

        controller.user_signed_in?.should be_true
      end
    end
  end
end

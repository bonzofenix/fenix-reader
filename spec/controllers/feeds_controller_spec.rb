require 'spec_helper'

describe FeedsController do
  describe 'when logged in' do

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        response.should be_success
      end
    end

    describe "POST subscribe" do
    before(:each) do
      @user = create(:user)
      sign_in @user
      Channel.any_instance.stub(check_url: false)
    end
      it "returns http success" do
        post :subscribe, url: 'www.google.com'
        response.should be_success
      end

      it "returns http success" do
        expect do
          post :subscribe, url: 'www.google.com'
        end.to change{ Channel.count }
      end
    end
  end

end

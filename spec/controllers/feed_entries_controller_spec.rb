require 'spec_helper'

describe FeedEntriesController do
  let(:user){ create :user }
  let(:channel){ create :channel, user: user }
  let(:feed){ create :feed_entry, channel: channel }

  describe 'when logged in' do
    before(:each) do
      sign_in user
      Channel.any_instance.stub(check_url: true) 
      Channel.any_instance.stub(set_title: true) 
      #Channel.any_instance.stub(:get_response).and_return( get_xml(:atom) )
    end

    describe 'GET index' do
      it 'returns http success' do
        get 'index'
        response.should be_success
      end

      it 'returns all the feeds' do
        feed
        get 'index'
        assigns(:feed_entries).length.should == 1
        response.should be_success
      end
    end

    describe "POST subscribe" do
      it "returns http success" do
        post :subscribe, url: 'www.google.com'
        response.should be_success
      end

      it 'returns http success' do
        expect do
          post :subscribe, url: 'www.google.com'
        end.to change{ Channel.count }
      end

      it 'renders index' do
        post :subscribe, url: 'www.google.com'
        response.should render_template('index')
      end

      it 'cant add the channel because the url is wrong so flash the error' do
        Channel.any_instance.stub(check_url: false)
        post :subscribe, url: 'www.wrong-url.com'
        flash[:error].should 
          have_content('Can not subscribe to this url. Verify that is a valid rss/atom service') 
      end
    end
  end

end

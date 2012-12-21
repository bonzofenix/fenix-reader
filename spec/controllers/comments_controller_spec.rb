require 'spec_helper'

describe CommentsController do
  let(:user){ create :user }
  let(:channel){ create :channel, user: user }
  let(:feed){ create :feed_entry, channel: channel}

  before(:each) do
    Channel.any_instance.stub(check_url: true) 
    Channel.any_instance.stub(set_title: true) 
  end

  describe 'when creating a comment' do
    it 'should render nothing on success' do
      post :create, feed_entry_id: feed.id,
        comment: attributes_for(:comment), format: 'js'
      response.should be_success
      debugger
      response.body.should have_text(" ")
    end

    it 'creates the comment' do
      expect do
        post :create ,feed_entry_id: feed.id, comment: attributes_for(:comment)
      end.to change{ Comment.count }.by(1)
    end

    it 'it assings the comment to the feed automatically' do
      post :create, feed_entry_id: feed.id, comment: attributes_for(:comment)
      feed.comments.count.should == 1  
    end
  end
end

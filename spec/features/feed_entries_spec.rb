require 'spec_helper'

feature 'Sets starts in the feed', js: true do
  let(:user){ create :user }
  let(:channel){ create :channel, user: user}
  let(:feed){ create :feed_entry, channel: channel}

  before :each do
    Channel.any_instance.stub(check_url: true) 

    feed
  end

  background do
    feature_sign_in(user)
    visit feed_entries_path
  end
  
  scenario 'changes the starts of a feed' do
    feed.stars.should be_nil 
    within("#edit_feed_entry_#{feed.id}") do
      # Seems that this is a bug from capybara so an option is to change the select
      # with jquery
      page.select_option '3 star', from: 'feed_entry_stars'
      #apge.execute_script("$('#edit_feed_entry_#{feed.id} select').val('3')")
    end
    save_and_open_page
    feed.reload.stars.should == 3
  end
end

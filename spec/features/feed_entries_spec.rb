require 'spec_helper'

feature 'Sets starts in the feed', js: true do
  let(:user){ create :user }
  let(:channel){ create :channel, user: user}
  let(:feed){ create :feed_entry, channel: channel}
  let(:other_feed){ create :feed_entry, channel: channel}

  before :each do
    Channel.any_instance.stub(check_url: true) 
    Channel.any_instance.stub(set_title: true) 
  end

  background do
    other_feed
    feature_sign_in(feed.channel.user)
    visit feed_entries_path
  end
  
  scenario 'changes the starts of a feed' do
    feed.stars.should == 0
    within("#edit_feed_entry_#{feed.id}") do
      # Seems that this is a bug from capybara so an option is to change the select
      # with jquery
      select '3 star', from: 'feed_entry_stars'
      page.execute_script("$('#edit_feed_entry_#{feed.id} select').val('3')")
    end
    feed.reload.stars.should == 3
  end

  scenario 'search in summary' do
    feed.update_attribute(:summary, 'this is not the text you are looking for')
    other_feed.update_attribute(:summary, 'this is the text you are looking for')
    within('#filters')  do
      fill_in 'Search by summary', with: other_feed.summary[0..20]
      click_button 'Search'
    end
    page.should have_css("div.feed_entries li", count: 1) 
  end

  scenario 'search in title' do
    feed.update_attribute(:title, 'this is not the text you are looking for')
    other_feed.update_attribute(:summary, 'this is the text you are looking for')
    within('#filters')  do
      fill_in 'Search by title', with: other_feed.title[0..20]
      click_button 'Search'
    end
    page.should have_css("div.feed_entries li", count: 1) 
  end

  scenario 'adds a comment' do
    pending
    feed
    page.should have_css("div.feed_entries li ul.comments li", count: 0) 
    feed_container_id =  "#feed_entry_#{feed.id}"
    within(feed_container_id) do
      fill_in 'Comment in here', with: 'this is a new comment'
      find("#{feed_container_id} .comment_input").native.send_keys(:return)
    end
    page.should have_css("div.feed_entries li ul.comments li", count: 1) 
  end
end

require 'spec_helper'

feature 'Authentication with omniauth' do
  background do
    visit root_path
    logged_in?.should be_false
  end

  scenario 'using OmniAuth Developer strategy' do
    OmniAuth.config.add_mock :developer, uid: 'bob@smith.com', info: { name: 'Bob' }
    click_on 'Login as OmniAuth Developer'

    page.should have_content 'Logged into developer as Bob (bob@smith.com)'
    logged_in?.should be_true
  end

  scenario 'using Facebook' do
    OmniAuth.config.add_mock :facebook, uid: 'fb-12345', info: { name: 'Bob Smith' }
    click_on 'Login with Facebook'

    page.should have_content 'Logged into facebook as Bob Smith (fb-12345)'
    logged_in?.should be_true
  end

  scenario 'using Twitter' do
    OmniAuth.config.add_mock :twitter, uid: 'twitter-12345', info: { name: 'Bob Smith' }
    click_on 'Login with Twitter'

    page.should have_content 'Logged into twitter as Bob Smith (twitter-12345)'
    logged_in?.should be_true
  end

  scenario 'invalid login' do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    click_on 'Login with Twitter'

    page.should have_content 'Login failed'
    logged_in?.should be_false
  end
end

# This is an example of logging into a website using OmniAuth by bypassing the 
# site's real login links/buttons and directly visiting the /auth/:provider URL 
# (which redirects to /auth/:provider/callback with mocked credentials).
#
# This doesn't add code coverage to your site's actual login UI, but it puts you 
# into a logged in state (plus you don't have to visit the home page first to 
# find a button to click, which will save you 1 request per logged in spec).
feature 'Logging in directly' do

  background do
    visit root_path
    logged_in?.should be_false
  end

  scenario 'using OmniAuth Developer strategy' do
    login_with :developer, uid: 'bob@smith.com', info: { name: 'Bob' }

    page.should have_content 'Logged into developer as Bob (bob@smith.com)'
    logged_in?.should be_true
  end

  scenario 'using Facebook' do
    login_with :google, uid: 'gl-12345', info: { name: 'Bob Smith' }

    page.should have_content 'Logged into google as Bob Smith (fb-12345)'
    logged_in?.should be_true
  end

  scenario 'using Twitter' do
    login_with :twitter, uid: 'twitter-12345', info: { name: 'Bob Smith' }

    page.should have_content 'Logged into twitter as Bob Smith (twitter-12345)'
    logged_in?.should be_true
  end

  scenario 'invalid login' do
    login_with :twitter, :invalid_credentials

    page.should have_content 'Login failed'
    logged_in?.should be_false
  end

  scenario 'valid login (without passing credentials)' do
    OmniAuth.config.add_mock :twitter, uid: 'twitter-12345', info: { name: 'Bob Smith' }
    login_with :twitter

    page.should have_content 'Logged into twitter as Bob Smith (twitter-12345)'
    logged_in?.should be_true
  end

  scenario 'invalid login (without passing credentials)' do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    login_with :twitter

    page.should have_content 'Login failed'
    logged_in?.should be_false
  end
end

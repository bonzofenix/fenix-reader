module FeatureHelpers

  def feature_sign_in(user)
    visit root_path
    within("#new_session") do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end
  end

  def logged_in?
    page.has_selector? "a", text: "Logout"
  end

  def login_with(provider, mock_options = nil)
    if mock_options == :invalid_credentials
     OmniAuth.config.mock_auth[provider] = :invalid_credentials
    elsif mock_options
      OmniAuth.config.add_mock provider, mock_options
    end

    visit "/auth/#{provider}"
  end
end

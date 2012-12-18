module FeatureHelpers
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

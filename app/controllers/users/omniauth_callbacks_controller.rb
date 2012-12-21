class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  [:twitter, :google_oauth2].each do |service|
    define_method(service) do
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.send("find_for_#{service}", request.env["omniauth.auth"])
      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication
        
        set_flash_message(:notice, :success,kind: service.to_s.capitalize) if is_navigational_format?
      else
        session["devise.#{service.to_s}_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end
end

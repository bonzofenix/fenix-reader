module HomeHelper
  # Since we are showing devise login and signup forms in the home page
  # we need to specify the following resource_name, resource and devise_mapping
  def resource_name
    :user 
  end

  def resource
    @resource ||= User.new
  end 

  def resource
    @resource ||= User.new
  end 
  
  def resource_class
    devise_mapping.to
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end 
end

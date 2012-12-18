require 'spec_helper'

describe HomeController do

  describe 'GET index' do
    it 'returns http success' do
      sign_in nil
      get 'index'
      response.should be_success
    end
  end
end

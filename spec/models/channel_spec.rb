require 'spec_helper'

describe Channel do
  let(:channel){ build :channel, :with_user }

  describe 'when checking the url' do

    it 'call check_url before saving' do   
      channel.should_receive :check_url
      channel.save
    end

    it 'checks that it can connect' do
      Channel.any_instance.stub(get_response:  '')
      channel.save
      channel.should_not be_persisted
    end

    it 'checks that its rss' do
      Channel.any_instance.stub(get_response:  get_xml(:rss))
      channel.save 
      channel.should be_persisted
    end

    it 'checks that its atom' do
      Channel.any_instance.stub(get_response:  get_xml(:atom))
      channel.save 
      channel.should be_persisted
    end
  end
end

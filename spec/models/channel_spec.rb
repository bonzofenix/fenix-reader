require 'spec_helper'

describe Channel do
  let(:user){ create :user }
  let(:channel){ build :channel, user: user }
  let(:atom_xml){ get_xml(:atom) }
  let(:rss_xml){ get_xml(:rss) }

  describe 'when checking the url' do

    it 'call check_url before saving' do   
      channel.should_receive :check_url
      channel.should_receive :set_title
      channel.save
    end

    it 'checks that it can connect' do
      Channel.any_instance.stub(get_response:  '')
      channel.save
      channel.should_not be_persisted
    end

    it 'does not overwrite the title if it was changed or exits' do
      Channel.any_instance.stub(:get_response).and_return( atom_xml )
      old_channel = create :channel, user: user, title: 'custom title'
      old_channel.save 
      old_channel.title.should_not == 'My Simple Feed'
    end

    it 'adds the title of the channel if possible' do
      Channel.any_instance.stub(:get_response).and_return( atom_xml )
      channel.save 
      channel.title.should == 'My Simple Feed'
    end

    it 'checks that its rss' do
      Channel.any_instance.stub(:get_response).and_return( rss_xml )
      channel.save 
      channel.should be_persisted
    end

    it 'checks that its atom' do
      Channel.any_instance.stub(:get_response).and_return( atom_xml )
      channel.save 
      channel.should be_persisted
    end
  end
end

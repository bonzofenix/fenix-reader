class Channel < ActiveRecord::Base
  attr_accessible :url
  before_save :check_url
  
  # IF feedzirra finds a parser for the xml that the url returned then the 
  # URL is fine.
  def check_url
    xml = get_response(url)
    parser = Feedzirra::Feed.determine_feed_parser_for_xml(xml)
    !parser.nil?
  end
    
  def get_response(url)
    Net::HTTP.get_response(URI.parse(url)).body
  end
end

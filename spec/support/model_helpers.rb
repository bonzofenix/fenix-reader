module ModelHelpers
  def get_xml(type)
    case type
      when :rss
        '''
        <?xml version="1.0" encoding="ISO-8859-1" ?>
        <rss version="2.0">
          <channel>
            <title>W3Schools Home Page</title>
            <link>http://www.w3schools.com</link>
            <description>Free web building tutorials</description>
            <item>
              <title>RSS Tutorial</title>
              <link>http://www.w3schools.com/rss</link>
              <description>New RSS tutorial on W3Schools</description>
            </item>
          </channel>
        </rss>
        '''
      when :atom
        '''
        <feed xmlns="http://www.w3.org/2005/Atom" xml:lang="en" xml:base="http://www.example.org">
          <id>http://www.example.org/myfeed</id>
          <title>My Simple Feed</title>
          <updated>2005-07-15T12:00:00Z</updated>
          <link href="/blog" />
          <link rel="self" href="/myfeed" />
          <entry>
            <id>http://www.example.org/entries/1</id>
            <title>A simple blog entry</title>
            <link href="/blog/2005/07/1" />
            <updated>2005-07-15T12:00:00Z</updated>
            <summary>This is a simple blog entry</summary>
          </entry>
        </feed>
        '''
    end
  end
end

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "eightbitraptor"
    xml.description "The personal blog of developer, music lover and recovering sysadmin Matt House"
    xml.link "http://eightbitraptor.com/posts"

    for post in locals[:posts]
      xml.item do
        xml.title post.title
        xml.description to_html(post.body)
        xml.pubDate pretty_date(post.published)
        xml.link post_url(post)
      end
    end
  end
end
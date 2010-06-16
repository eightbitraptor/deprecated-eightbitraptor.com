require File.dirname(__FILE__) + "/test_helper.rb"

class PostTest < Test::Unit::TestCase

  context "Given a valid path" do
    setup do
      @path = File.join(File.dirname(__FILE__), %w{ dummy_post.markdown })
    end
    
    should "create a valid review" do
      post = Post.new(@path)
      assert_equal "Dummy Title", post.title
      assert_equal "2010-05-05", post.published
      assert_equal "Matt House", post.author
    end
  end
  
  context "with multiple posts" do 
    setup do
      title_array = ["",""]
      Dir.stubs("[]").returns(title_array)
    end
    
    
  end

end
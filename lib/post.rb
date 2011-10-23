require 'pathname'

class Post

  class << self

    def all
      Dir[File.expand_path('../../posts/*.md', __FILE__)].map{ |post| new(post) }.sort!
    end

    def find(name)
      Dir[File.expand_path("../../posts/#{name}.md", __FILE__)].map{ |post| new(post) }.first
    end

    def find_by_tag(category)
      Post.all.select{ |p|
        p.tags.include? category
      }.sort!
    end

    def most_recent(quant=1)
      Post.all.sort!.take(quant)
    end
  end

  def initialize(path)
    lines = File.open(path)

    body = lines.map do |l|
      if l.match /^::(.*)::(.*)$/
        v = ($1 == 'published') ? Date.parse($2) : $2 
        instance_variable_set("@#{$1}", $2.strip )
        self.class.send(:attr_accessor, "#{$1}")
        nil
      else
        l
      end
    end.compact!

    @tags = @tags.split(',')

    {
      "printable_pathname" => Pathname.new(path).basename.to_s.split('.').first,
      "body" => body.join
    }.each do |k,v|
      instance_variable_set("@#{k}", v)
      self.class.send(:attr_accessor, k)
    end
  end

  def <=>(other)
    other.published <=> self.published
  end

end

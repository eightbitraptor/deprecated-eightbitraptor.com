require 'maruku'

class Post

  attr_accessor :body

  class << self

    def all
      puts Dir[File.join(File.dirname(__FILE__), %w{.. posts *.markdown})].inspect
      Dir[File.join(File.dirname(__FILE__), %w{.. posts *.markdown})].map{ |path| new(path) }
    end

    def find(name)
      Dir[File.join(File.dirname(__FILE__), %W{.. posts #{name}.markdown})].map{|post| new(post) }.first
    end

  end
  
  def initialize(path)
    lines = File.open(path)
    options = {}
    body = []
    lines.each do |l|
      if l.match /::(.*)::(.*)/
        options[$1] = $2.strip
      else
        body << l
      end
    end
    options.map do |option|
      instance_variable_set("@#{option[0]}", option[1])
      self.class.send(:attr_accessor, "#{option[0]}")
    end
    instance_variable_set("@body", body.to_s)
    self.class.send(:attr_accessor, "body")
  end
  
  def to_html
    Maruku.new(@body).to_html
  end

end

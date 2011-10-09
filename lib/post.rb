require 'pathname'
require 'pp'

class Post

  class << self

    def all
      Dir[File.join(File.dirname(__FILE__), %w{.. posts *.md})].map{ |path| new(path) }.sort!
    end

    def find(name)
      Dir[File.join(File.dirname(__FILE__), %W{.. posts #{name}.md})].map{|post| new(post) }.first
    end

    def find_by_tag(category)
      Dir[File.join(File.dirname(__FILE__), %w{.. posts *.md})].map{ |post| new(post) }.select{ |p|
        p.tags.include? category
      }.sort!
    end

    def most_recent(quant=1)
      Dir[File.join(File.dirname(__FILE__), %w{.. posts *.md})].map{ |post| new(post) }.sort!.take(quant)
    end
  end

  def initialize(path)
    lines = File.open(path)
    options = {}
    options[:printable_pathname] = Pathname.new(path).basename.to_s.split('.')[0]
    body = []
    lines.each do |l|
      if l.match /^::(.*)::(.*)$/
        options[$1.to_sym] = $2.strip
      else
        body << l
      end
    end

    options.map do |option|
      payload = ( option[0] == :tags ) ? option[1].split(',') : option[1]
      instance_variable_set("@#{option[0]}", payload )
      self.class.send(:attr_accessor, "#{option[0]}")
    end
    instance_variable_set("@body", body.join)
    self.class.send(:attr_accessor, "body")
  end

  def <=>(other)
    other.published <=> self.published
  end

end

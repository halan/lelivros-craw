require 'yaml'

class BrokenLinks
  def initialize(filename = 'downloads/broken.yml')
    @filename = filename
    @yaml = load_file
    @yaml[:broken] ||= []
  end

  def load_file
    if File.exists? @filename
      YAML.load_file(@filename)
    else
      {broken: []}
    end
  end

  def broken
    @yaml[:broken]
  end

  def save
    File.open(@filename, 'w') {|f| f.write @yaml.to_yaml }
  end

  def register(filename, href, title, page)
    broken << {
      title: title.to_s,
      filename: filename.to_s,
      href: href.to_s,
      page: page.to_s
    }
    save
  end

  def has?(title)
    broken.select{|r| r[:title] == title.to_s }.any?
  end

  def self.instance
    @instance ||= new
  end

  def self.register(filename, href, title, page)
    instance.register(filename, href, title, page)
  end

  def self.has?(title)
    instance.has?(title)
  end
end

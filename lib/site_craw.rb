class SiteCraw
  def initialize(url, format = 'mobi', reporter = Reporter.new)
    @url = url
    @format = format
    @browser = Mechanize.new
    @reporter = reporter
  end

  def craw!
    craw_areas!
    @areas.each { |area| SiteAreaCraw.new("#{@url}#{area[:href]}", area[:title], @format, @reporter).craw! }
  end

  def craw_areas!
    @areas = @browser.get(@url).
      search('.cat-item a').map{|a| {title: a.text, href: a[:href] } }
  end
end

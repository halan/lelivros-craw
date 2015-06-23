class SiteCraw
  def initialize(url, format = 'mobi')
    @url = url
    @format = format
    @browser = Mechanize.new
  end

  def craw!
    craw_areas!
    @areas.each { |area| SiteAreaCraw.new(area[:href], area[:title], @format).craw! }
  end

  def craw_areas!
    @areas = @browser.get('http://lelivros.red/').
      search('.cat-item a').map{|a| {title: a.text, href: a[:href] } }
  end
end

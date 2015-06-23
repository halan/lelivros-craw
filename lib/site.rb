class SiteCraw
  def initialize(url)
    @url = url
    @browser = Mechanize.new
  end

  def craw!
    craw_areas!
    @areas.each do |area|
      puts "===> #{area[:title]}"
      SiteAreaCraw.new(area[:href], area[:title]).craw!
    end
  end

  def craw_areas!
    @areas = @browser.get('http://lelivros.red/').search('.cat-item a').map{|a| {title: a.text, href: a[:href] }}
  end
end

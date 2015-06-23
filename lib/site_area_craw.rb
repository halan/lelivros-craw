class SiteAreaCraw
  def initialize(url, title, format = 'mobi', reporter = Reporter.new)
    @url = url
    @title = title
    @reporter = reporter
    @format = format
    @browser = Mechanize.new
  end

  def craw!
    @reporter.start_area(@title)
    all_urls.each { |url| navigate_and_download(url) }
  end

  protected

  def navigate_and_download(url)
    books = BooksCraw.new(@format, @reporter)
    books.append PageCraw.new(@browser.get(url), @format).links
    books.download!("downloads/#{@title}")
  end

  def pages_count
    @pages_count ||= @browser.get(@url).search('.pages').text[/[0-9]+$/].to_i
  end

  def route_to(number)
    "#{@url}/page/#{number}"
  end

  def all_urls
    @all_urls ||= (1..pages_count).map{|number| route_to(number) }
  end
end



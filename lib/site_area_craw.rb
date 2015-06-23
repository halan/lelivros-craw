class SiteAreaCraw
  def initialize(url, title, format = 'mobi', reporter = Reporter.new)
    @url = url
    @title = title
    @reporter = reporter
    @initial_page = url
    @format = format
    @browser = Mechanize.new
    @books = BooksCraw.new(format, reporter)
  end

  def craw!
    @reporter.start_area(@title)

    begin
      page_craw = PageCraw.new(@browser.get(@url), @format)
      @books.append(page_craw.links) and @books.download!("downloads/#{@title}")
      @url = page_craw.next_page_url
    end while page_craw.next_page
  end
end



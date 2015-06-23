class BooksCraw
  def initialize(format = 'mobi', reporter = Reporter.new)
    @format = format
    @reporter = reporter
    @book_links = []
    @browser = Mechanize.new
  end

  def download!(dir = 'downloads')
    FileUtils::mkdir_p dir
    @book_links.each do |link|
      filename = "#{dir}/#{link[:title].format(@format)}"
      download_or_keep filename, link[:href], link[:title], link[:page]
    end
    @book_links = []
  end

  def append(page_links)
    @book_links += page_links.map do |page_link|
      page = @browser.get(page_link)
      {
        title: TitleBook.new(page.search('[itemprop=name]').text),
        href: page.link_with(href: %r{#{@format}$}).href,
        page: page_link
      }
    end
  end

  private

  def download_or_keep(filename, href, title, page)
    if File.exists?(filename)
      @reporter.download_exists(title)
    else
      begin
        @browser.download href, filename
        @reporter.download_ok(title)
      rescue Mechanize::ResponseCodeError
        @reporter.download_error(title)
        BrokenLinks.register(filename, href, title, page)
      end
    end
  end
end

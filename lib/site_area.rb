class SiteAreaCraw
  def initialize(url, title)
    @url = url
    @title = title
    @initial_page = url
    @browser = Mechanize.new
    @books = BooksCraw.new
  end

  def craw!
    begin
      page_craw = PageCraw.new(@browser.get @url)
      @books.append(page_craw.links) and @books.download!("downloads/#{@title}")
      @url = page_craw.next_page_url
    end while page_craw.next_page
  end

  def download!
    @books.download!
  end

  def pages
    page = @browser.get @initial_page
    page.link_with(class: 'last').href[/([0-9]+)\//, 1].to_i
  end
end



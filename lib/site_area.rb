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
end



class BooksCraw
  def initialize()
    @book_links = []
    @browser = Mechanize.new
  end

  def download!(dir = 'downloads')
    FileUtils::mkdir_p dir
    @book_links.each do |link|
      begin
        @browser.download link[:href], "#{dir}/#{link[:title]}.mobi"
        puts "-----> #{link[:title]}"
      rescue Mechanize::ResponseCodeError
        warn "Erro - #{link[:title]}"
      end
    end
    @book_links = []
  end

  def length
    @book_links.length
  end

  def append(page_links)
    @book_links += page_links.map do |page_link|
      page = @browser.get(page_link)
      {
        title: page.search('[itemprop=name]').text,
        href: page.link_with(href: /mobi$/).href
      }
    end
  end
end



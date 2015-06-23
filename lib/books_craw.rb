class BooksCraw
  def initialize(format = 'mobi')
    @format = format
    @book_links = []
    @browser = Mechanize.new
  end

  def download!(dir = 'downloads')
    FileUtils::mkdir_p dir
    @book_links.each do |link|
      filename = "#{dir}/#{link[:title].format(@format)}"
      download_or_keep filename, link[:href], link[:title]
    end
    @book_links = []
  end

  def append(page_links)
    @book_links += page_links.map do |page_link|
      page = @browser.get(page_link)
      {
        title: TitleBook.new(page.search('[itemprop=name]').text),
        href: page.link_with(href: %r{#{@format}$}).href
      }
    end
  end

  private

  def download_or_keep(filename, href, title)
    if File.exists?(filename)
      puts "!----- #{title}"
    else
      begin
        @browser.download href, filename
        puts "-----> #{title}"
      rescue Mechanize::ResponseCodeError
        warn "Erro - #{title}"
        File.write "#{filename}[error].txt", href
      end
    end
  end
end



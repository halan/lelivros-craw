class PageCraw
  def initialize(page, format)
    @page = page
    @format = format
  end

  def links
    @page.search('.product').reject do |li|
      title = TitleBook.new li.search('h3').text
      BrokenLinks.has?(title) ||  exist?(title)
    end.map{|li| li.search('[data-product_id]').first[:href] }
  end

  def next_page
    @page.link_with(text: /Próxima/)
  end

  def next_page_url
    next_page.href if next_page
  end

  private

  def exist?(title)
    Dir["downloads/*/#{title.format(@format)}"].any?
  end
end



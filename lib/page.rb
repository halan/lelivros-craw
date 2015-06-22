class PageCraw
  def initialize(page)
    @page = page
  end

  def links
    @page.search('.product').reject do |li|
      Dir["downloads/**/#{li.search('h3').text.gsub('/', '|')}.mobi"].any?
    end.map{|li| li.search('[data-product_id]').first[:href] }
  end

  def next_page
    @page.link_with(text: /Próxima/)
  end

  def next_page_url
    next_page.href if next_page
  end
end



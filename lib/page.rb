class PageCraw
  def initialize(page)
    @page = page
  end

  def links
    @page.search('.product').reject do |li|
      exist? li.search('h3').text
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
    filename = "#{title.gsub('/', '|').gsub('[', '\[')}.mobi"
    Dir[
      "downloads/*/#{filename}",
      "downloads/*/#{filename}\\[error\\].txt",
    ].any?
  end
end



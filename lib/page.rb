class PageCraw
  def initialize(page)
    @page = page
  end

  def links
    @page.search('[data-product_id]').map { |link| link[:href] }
  end

  def next_page
    @page.link_with(text: /Próxima/)
  end

  def next_page_url
    next_page.href if next_page
  end
end



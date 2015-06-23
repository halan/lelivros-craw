class Reporter
  def start_area(title)
    puts "===> #{title}"
  end

  def download_ok(title)
    puts "-----> #{title}"
  end

  def download_error(title)
    warn "Erro - #{title}"
  end

  def download_exists(title)
    puts "!----- #{title}"
  end
end

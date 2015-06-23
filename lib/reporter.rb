class Reporter
  def start_area(title)
    puts blue "===> #{title}"
  end

  def download_ok(title)
    puts green "-----> #{title}"
  end

  def download_error(title)
    warn red "Erro - #{title}"
  end

  def download_exists(title)
    puts brown "!----- #{title}"
  end

  private

  def red(s);   "\033[31m#{s}\033[0m" end
  def green(s); "\033[32m#{s}\033[0m" end
  def brown(s); "\033[33m#{s}\033[0m" end
  def blue(s);  "\033[34m#{s}\033[0m" end
end

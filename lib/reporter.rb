class Reporter
  def initialize
    @successes = []
    @errors = []
    @duplicateds = []
    @areas = []
  end

  def start_area(title)
    puts Colors.blue "===> #{title}"
    @areas << title
  end

  def download_ok(title)
    puts Colors::green "-----> #{title}"
    @successes << title
  end

  def download_error(title)
    warn Colors::red "Erro - #{title}"
    @errors << title
  end

  def download_exists(title)
    puts Colors::brown "!----- #{title}"
    @duplicateds << title
  end

  def summary
    puts ''
    puts [
      summary_message('Success', @successes.count, :green),
      summary_message('Error', @errors.count, :red),
      summary_message('Duplicated', @duplicateds.count, :brown),
      summary_message('Categories', @areas.count, :blue)
    ].compact.join ' | '
  end

  private

  def summary_message label, count, color
    "#{label}: #{Colors::send color, count}" unless count.zero?
  end

  module Colors
    def self.red(s);   "\033[31m#{s}\033[0m" end
    def self.green(s); "\033[32m#{s}\033[0m" end
    def self.brown(s); "\033[33m#{s}\033[0m" end
    def self.blue(s);  "\033[34m#{s}\033[0m" end
  end
end

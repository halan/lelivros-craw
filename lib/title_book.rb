class TitleBook
  def initialize(title)
    @title = title
  end

  def format(s)
    "#{strip}.#{s}"
  end

  def mobi
    format 'mobi'
  end

  def strip
    "#{@title.gsub('/', '|').gsub('[', '\[')}"
  end
end

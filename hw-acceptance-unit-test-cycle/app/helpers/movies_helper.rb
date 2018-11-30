module MoviesHelper
  def oddness(count)
    count.odd? ? 'odd' : 'even'
  end
end

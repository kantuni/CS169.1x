module MoviesHelper
  def oddness(count)
    count.odd? ? 'odd' : 'even'
  end

  def hilite(column)
    'hilite' if session[:sort_by] == column
  end
end

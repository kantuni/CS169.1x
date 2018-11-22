module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ? 'odd' : 'even'
  end

  def highlight(column)
    'hilite' if session[:sort_by] == column
  end

  def selected(rating)
    return true unless session.key? :ratings
    session[:ratings].keys.include? rating
  end
end

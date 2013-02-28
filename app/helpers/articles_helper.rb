module ArticlesHelper
  def with_date(a_date)
    { month: a_date.month, year: a_date.year }
  end
end

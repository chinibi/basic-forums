module UsersHelper
  def format_datetime(datetime)
    datetime.strftime("%e %B %Y %r")
  end
end

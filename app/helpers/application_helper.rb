module ApplicationHelper
  def heroicon(name, options = {})
    icon name, library: :heroicons, **options
  end
end

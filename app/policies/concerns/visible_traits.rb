module VisibleTraits
  extend ActiveSupport::Concern

  def visible?
    record&.visible?
  end
end

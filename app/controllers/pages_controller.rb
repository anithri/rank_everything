class PagesController < ApplicationController
  allow_unauthenticated_access
  def home
  end

  def about
    add_breadcrumb "About", :about_path
  end
end

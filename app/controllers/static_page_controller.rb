class StaticPageController < ApplicationController
  def index
  end

  def admin
    render 'admin', layout: 'admin'
  end

end

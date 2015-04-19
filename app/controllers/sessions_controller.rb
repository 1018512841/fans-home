# -*- encoding : utf-8 -*-
# session
class SessionsController < ApplicationController
  def change_locale
    locale = params[:locale].to_s.downcase
    if LANGUAGES.has_value? locale
      if locale != session[:default_locale]
        session[:default_locale] = locale
        I18n.locale = locale
        render json: {}
      end
    end
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_i18n_session

  private

  def set_i18n_session
    unless session[:default_locale]
      accept_language = get_default_locale(request.env['HTTP_ACCEPT_LANGUAGE'])
      set_locale(accept_language)
    end
  end

  def get_default_locale(language_request)
    language = language_request.scan(/^[a-z]{2}/).first
    if language.downcase == "zh"
      language = "zh"
    else
      language = 'en'
    end
    return language
  end

  def set_locale(locale)
    I18n.locale = session[:default_locale] = locale
  end
end

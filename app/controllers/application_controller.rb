class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  LIMIT_OF_RELATED_PRODUCTS = 4
end

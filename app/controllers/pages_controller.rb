class PagesController < ApplicationController

  def home
  	redirect_to products_path if is_logged_in
  end

end
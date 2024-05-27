class TopsController < ApplicationController
  skip_before_action :require_login, only: %i[index privacy terms]
  def index; end

  def privacy; end

  def terms; end
end

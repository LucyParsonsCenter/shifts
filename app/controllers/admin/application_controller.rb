class Admin::ApplicationController < Administrate::ApplicationController
  before_action :authenticate_user!

  def records_per_page
    params[:per_page] || 30
  end
end

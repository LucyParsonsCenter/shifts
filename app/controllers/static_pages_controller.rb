class StaticPagesController < ApplicationController

  def home
    render :home
  end

  def help
    render :help
  end
end

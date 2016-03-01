class StaticPagesController < ApplicationController

  def home
    render :home
  end

  def help
    render :help
  end

  def about
    render :about
  end

  def letsencrypt
    render text: "KCQ0kRgreeQjSl7C4358AX7eVrYl_GUicPVR3hUThMw.vyei9LUnoD7AxLw6GOcsWiaTNQBADMMpSYOu8Yb57V8"
  end
end

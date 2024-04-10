class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top privacy_policy terms_of_use]

  def top
    if logged_in?
      render 'top'
    else
      render 'before_login_top'
    end
  end

  def def privacy_policy; end
  def def terms_of_use; end
end

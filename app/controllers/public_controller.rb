class PublicController < ApplicationController
  skip_before_filter :authenticate_user!

  def privacy
  end

  def conditions
  end
end

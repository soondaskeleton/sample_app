class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end
end
  
  def help
  end

  def about
  end

  def contact
  end

  def signup
  end
  
  end

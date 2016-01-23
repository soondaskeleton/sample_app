module SessionsHelper
# logs in the user
  def log_in(user)
    session[:user_id] = user.id
  end

  # this remembers a user in a persistent session
def remember(user)
  user.remember
  cookies.permanent.signed[:user_id] = user.id
  cookies.permanent[:remember_token] = user.remember_token
end

  # this returns the current logged in user (if there are any)
  def current_user
    if (user_id = session[:user_id])
    @current_user ||= User.find_by(id: user_id)
  elsif (user_id = cookies.signed[:user_id])
  #raise # the tests still pass, so this branc is currently untested 
    user = User.find_by(id: user_id)
    if user && user.authenticated?(:remember, cookies[:remember_token])
      log_in user
      @current_user = user
    end
  end
end

  #this returns true if the user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end
# forgets a persistent session
def forget(user)
  user.forget
  cookies.delete(:user_id)
  cookies.delete(:remember_token)
end
# logs out the current user
def log_out
  session.delete(:user_id)
  @current_user = nil
end
#redirects to stored location or to the default location 
def redirect_back_or(default)
  redirect_to(session[:forwarding_url] || default)
  session.delete(:forwarding_url)
end

def store_location #stores the URL trying to be accessed
  session[:forwarding_url] = request.url if request.get?
end
end
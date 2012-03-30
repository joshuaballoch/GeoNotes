module SessionsHelper
  def sign_in(user)
    cookies.signed[:remember_token] = {:value => [user.id, user.salt]}
    current_user = user
    @current_user = user
  end
  
  def signed_in?
    return !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
    @current_user = nil
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def authenticate
    deny_access
  end
  
  def deny_access
    unless signed_in? 
      flash[:notice]="Please create an account."
      redirect_to root_path
    end
  end
  
  private
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil,nil]
    end
    
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?
  
  def current_user
    #return @current_user if already exists (se ja pegou no bd) 
    # ||= é o mesmo que if not(se nao pegou nada no bd ainda)   find this user (searched by user_id) if user_id exist
    @current_user ||=User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #se tiver um current user retorna true, se não, retorna false
    !!current_user
    
  end
  
  def require_user
    if !logged_in?
      flash[:danger] ="You must be logged in to peform that action"
      redirect_to root_path
    end
  end
  
end

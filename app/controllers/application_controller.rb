class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  private

  def current_user
    return unless session[:user_id]
    @current_user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def require_user_logged_in
    unless logged_in?
      redirect_to root_path
    end
  end

  def counts(board)
    @count_comments = board.comments.count
  end
end

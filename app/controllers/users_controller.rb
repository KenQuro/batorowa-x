class UsersController < ApplicationController
  before_action :set_target_user, only: %i[show edit update destroy]
  before_action :require_user_logged_in, only: %i[show edit update destroy]

  def new
    @user = User.new(flash[:user])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to boards_path
    else
      flash[:user] = user
      flash[:error_messages] = user.errors.full_messages
      redirect_back(fallback_location: login_path)
    end
  end

  def show
    @currentUserEntry = Entry.where(user_id: @current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == @current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom == true
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    unless @current_user == @user
      redirect_to boards_path
    end
  end

  def update
    if @current_user == @user
      if @user.update(user_params)
        flash[:success] = 'プロフィールを編集しました'
        redirect_to user_path
      else
        flash[:error_messages] = @user.errors.full_messages
        render :edit
      end
    else
      redirect_to boads_path
    end
  end

  def destroy
    @user = @current_user
    @user.destroy
    redirect_to root_path, flash: { notice: "「#{@user.name} が削除されました"}
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :platform, :password, :password_confirmation, :image)
  end

  def set_target_user
    @user = User.find(params[:id])
  end
end

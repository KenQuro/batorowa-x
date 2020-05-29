class MessagesController < ApplicationController
  before_action :require_user_logged_in

  def create
    if Entry.where(user_id: @current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: @current_user.id))
      redirect_to room_path(@message.room_id)
    else
      redirect_back(fallback_codation: root_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :message)
  end
end

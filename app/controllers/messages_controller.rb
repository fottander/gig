class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params

    if @message.valid?
      MessageMailer.message_me(@message).deliver_now
      redirect_to messages_path
      flash[:notice] = 'Vi har mottagit ditt meddelande och hör av oss så fort vi kan!'
    else
      flash[:alert] = 'Något gick fel, vänligen försök igen.'
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :phone_number, :body)
  end
end

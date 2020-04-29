class MessagesController < ApplicationController
  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Messages::Manual.new(message_params).call

    if @message
      redirect_to :messages
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end

class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :active_subscription?  

  def create
    @recipient = User.find_by(id: params[:recipient_id])
    @subject = params[:subject]
    @body = params[:body]
    if current_user.send_message(@recipient, @body, @subject)
      redirect_to user_path(@recipient)
    end
  end

  def show
    @conversation = Conversation.find_by(id: params[:id])
    @conversation.mark_as_read(current_user)
    @receipts = @conversation.receipts_for(current_user).reverse!
    @last_receipt = @receipts.last
  end

  def reply
    @receipt = Receipt.find_by(id: params[:receipt_id])
    @body = params[:body]
    if current_user.reply_to_all(@receipt, @body)  
      redirect_to conversations_path
    end
  end
end
 

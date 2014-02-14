class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :mailbox, :conversation
  before_filter :active_subscription? 

  def create
    conversation_params
    recipient_email = params[:conversation][:recipients]
    recipient = User.find_by_email(recipient_email)
    conversation = current_user.send_message(recipient, params[:conversation][:body], params[:conversation][:subject]).conversation
    redirect_to conversations_path
  end

  def index
    @user = current_user
    @conversation_initiations_remaining = current_user.conversation_initiations_remaining
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def reply
    message_params
    @conversation = current_user.mailbox.conversations.find(params[:id])
    current_user.reply_to_conversation(@conversation, params[:message][:body], params[:message][:subject])
    redirect_to conversations_path
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def delete
    conversation.mark_as_deleted(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def conversation_params
    params.require(:conversation).permit(
      :recipients,
      :body,
      :subject)
  end

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def email_param
    params.require(:conversation).permit(:recipients)
  end

  def message_params
    params.require(:message).permit(
      :body,
      :subject)
  end
end

class ConversationsController < ApplicationController
  before_filter :authenticate_user!

  def create
    conversation_params
    recipient_email = params[:conversation][:recipients]
    recipient = User.find_by_email(recipient_email)
    conversation = current_user.send_message(recipient, params[:conversation][:body], params[:conversation][:subject]).conversation
    render conversation
  end

  def index
    @inbox = current_user.mailbox.inbox
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def reply
    @conversation = current_user.mailbox.conversations.find(params[:id])
    current_user.reply_to_conversation(@conversation, *message_params)
    redirect_to @conversation
  end

  def trash
    conversation.move_to_trash(current_user)
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

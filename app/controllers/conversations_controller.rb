class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_conversation, :except => [:index]
  before_filter :active_subscription? 

  def index
    @inbox = current_user.mailbox.inbox
    @sentbox = current_user.mailbox.sentbox
    @trash = current_user.mailbox.trash
  end

  def trash
    @conversation.mark_as_read(current_user)
    @conversation.move_to_trash(current_user)
    redirect_to conversations_path
  end

  def untrash
    @conversation.untrash(current_user)
    redirect_to conversations_path
  end

  def delete
    @conversation.mark_as_deleted(current_user)
    redirect_to conversations_path
  end

  private

  def get_conversation
    @conversation = Conversation.find(params[:id])
  end
end

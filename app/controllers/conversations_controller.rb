class ConversationsController < ApplicationController
	before_action :authenticate_user!

	def index
		# On va creer une index de tout les conversations
		@conversations = Conversation.involving(current_user)
	end 

	def create
    if Conversation.between(params[:sender_id], params[:recepient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recepient_id]).first
    else
      @conversation = Conversation.create(conversation_params)
    end

    	redirect_to conversation_messages_path(@conversation)
 	end


	private

		def conversation_params
			params.permit(:sender_id, :recepient_id)
		end
end
class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy
	before_action :find_micropost, only: :create

	def create
		@comment = current_user.comments.build(comment_params)
		if @comment.save
		   flash[:success] = "Comment created!"
		   redirect_to micropost_path @micropost
		end
	end		
	def destroy
		@comment.destroy
		flash[:success] = "Comment deleted"
		redirect_to request.referrer || root_url
	end

	private
	
	def comment_params
		params.require(:comment).permit(:content, :user_id, :micropost_id)
	end

	def correct_user
		@comment = current_user.comments.find_by(id: params[:id])
		redirect_to root_url if @comment.nil?
	end

	def find_micropost
        @micropost = Micropost.find_by id: comment_params[:micropost_id]
	end
end


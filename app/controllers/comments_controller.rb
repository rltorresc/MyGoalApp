class CommentsController < ApplicationController
    def new
        @comment = Comment.new
    end
    def create
        @commentable = find_commentable
        @comment = @commentable.comments.new(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            redirect_to goal_url(@commentable) unless @commentable.is_a?(User)
            redirect_to user_url(@commentable) if @commentable.is_a?(User)
        else
            flash.now[:errors] = @comment.errors.full_messages
        end
    end

    def find_commentable
        params.each do |name, value|
            if name =~ /(.+)_id$/
                return $1.classify.constantize.find(value)
            end
        end
        nil
    end
    
     def destroy
          @comment = Comment.find(params[:id])
          if @comment.user_id == current_user.id
            @comment.destroy
            redirect_to goal_url(@comment.commentable) unless @comment.commentable.is_a?(User)
            redirect_to user_url(@comment.commentable) if @comment.commentable.is_a?(User)
          else
            flash[:errors] = "You can't delete other people's comments!"
            redirect_to goal_url(@comment.commentable) unless @comment.commentable.is_a?(User)
            redirect_to user_url(@comment.commentable) if @comment.commentable.is_a?(User)
          end
     end
    
     private
    
     def comment_params
          params.require(:comment).permit(:body)
     end    
end

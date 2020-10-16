class CommentsController < ApplicationController

    def index 
        comments = Comment.all 
        render json: comments
    end

    def create
        comment = Comment.new(comment_params)
        if comment.save
            render json: comment
        else 
            render json: {error: comment.errors.full_messages}, status: :not_acceptable
        end
    end

    def destroy
        comment = Comment.find(params[:id])
    
        comment.destroy
    
        render json: comment
      end

    private 

    def comment_params
        params.require(:comment).permit(:user_id, :recipe_id, :content)
    end
end

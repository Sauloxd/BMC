class CommentsController < ApplicationController
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.build comment_params
        @comment.save
        redirect_to article_path @article
    end

    private

    def comment_params
        params.require(:comment).permit(:author, :body, :status)
    end
end

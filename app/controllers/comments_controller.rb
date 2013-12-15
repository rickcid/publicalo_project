class CommentsController < ApplicationController
before_action :require_user

  def create
    @post = Post.find_by slug: params[:post_id]
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Felicidades, creaste un nuevo comentario."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, user: current_user, vote: params[:vote])
    
    respond_to do |format|
      format.html do
        if vote.valid?
          flash[:notice] = "Tu voto fue agregado."
        else
          flash[:error] = "Se permite votar solo una vez."
        end
        redirect_to :back
      end
      format.js
    end
  end
end

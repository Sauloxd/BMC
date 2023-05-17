class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  # Renders page with "NEW" form
  def new
    @article = Article.new
  end

  # Executes action and redirect to a view (SHOW or NEW)
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # FE for edit
  def edit
    @article = Article.find(params[:id])
  end

  # Action to update. Re routes accordingly
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Destroy
  def destroy
    @article = Article.find(params[:id])

    if @article.destroy
      redirect_to root_path, status: :see_other
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)    
  end
end

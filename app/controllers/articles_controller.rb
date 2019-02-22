class ArticlesController < ApplicationController
  
  def index
    @articles = Article.alphabetical.paginate(:page => params[:page]).per_page(10)
  end


  def show
    @article = Article.find(params[:id])
  end


  def new
    @article = Article.new
  end


  def edit
    @article = Article.find(params[:id])
  end


  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to article_path(@article)
    else
      render :action => "new"
    end

    # respond_to do |format|
    #   if @article.save
    #     format.html { redirect_to @article, notice: 'Article was successfully created.' }
    #     format.json { render :show, status: :created, location: @article }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @article.errors, status: :unprocessable_entity }
    #   end
    # end
  end






  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:notice] = 'Article was successfully updated.'
      redirect_to article_path(@article)
    else
      render :action => "edit"
    end
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :content, :category_id, :active)
  end
end

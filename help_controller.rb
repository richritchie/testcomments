class HelpController < ApplicationController
  before_action :set_article, only: [ :show ]
  before_action :set_markdown, only: [ :show ]

  # Let everyone see the help articles
  skip_before_filter :authenticate_user!

  def index
    @title = "Help Documentation"
    @categories = ArticleCategory.all_with_published_articles.rank(:position)
    @articles = Article.where(published:true).rank(:position)
  end

  def show
   @title = @article.title
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.friendly.find(params[:id])
  end

  def set_markdown
    # TODO: Use a *new* attr called renderer to allow for different types:
    #         HTML would be the default
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      highlight: true,
      quote: true
    )
  end

end

class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  def index
    render json: Post.preload(post_tags: [:tag])
  end

  def show
    render json: post
  end

  def create
    post_form = PostForm.new(post_params, tag_list_params)

    render body: nil, status: :created if post_form.save
  rescue StandardError => e
    logger.debug(e)
    render json: { message: e.message }, status: :bad_request
  end

  def update
    post_form = PostForm.new(post_params, tag_list_params, post: post)

    render body: nil, status: :no_content if post_form.save
  rescue StandardError => e
    logger.debug(e)
    render json: { message: e.message }, status: :bad_request
  end

  def destroy
    render body: nil, status: :no_content and return if post.destroy

    render body: nil, status: :bad_request
  end

  private

  attr_reader :post

  def set_post = @post = Post.find(params[:id])
  def post_params = params.require(:post).permit(:name, :content)
  def tag_list_params = params.require(:post).permit(tag_list: [])
end

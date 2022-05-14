class PostForm
  include ActiveModel::Model

  attr_accessor :name, :content

  validates :name, presence: true
  validates :content, presence: true, length: { maximum: 150 }

  def initialize(post_params, tag_list_params, post: Post.new)
    super(post_params)
    raise '入力項目を正しく入力してください。' if invalid?

    @post = post
    @tag_list = tag_list_params[:tag_list]
  end

  def save
    ActiveRecord::Base.transaction do
      post.update!(post_attributes)
      PostTagForm.new(tag_list, post.id).save
    end
  end

  private

  attr_reader :post, :tag_list

  def post_attributes = { name: name, content: content }
end

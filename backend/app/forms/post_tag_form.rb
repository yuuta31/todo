class PostTagForm
  include ActiveModel::Model

  def initialize(tag_list, post_id)
    @params_tag_list = TagForm.new(tag_list).tags
    @current_tag_list = initialize_current_tag_list(post_id)
    @post_id = post_id
  end

  def save
    old_tags = current_tag_list - params_tag_list
    new_tags = params_tag_list - current_tag_list

    destroy_tags = old_tags.map do |name|
      PostTag.find_by!(post_id: post_id, tag_id: Tag.find_by!(name: name).id,)
    end
    insert_tags = new_tags.map do |name|
      { post_id: post_id, tag_id: Tag.find_by!(name: name).id }
    end

    ActiveRecord::Base.transaction do
      destroy_tags.each(&:destroy!)
      PostTag.create!(insert_tags)
    end
  end

  private

  attr_reader :current_tag_list, :post_id, :params_tag_list

  def initialize_current_tag_list(post_id)
    PostTag.where(post_id: post_id).map { |post_tag| Tag.find(post_tag.tag_id).name }
  end
end

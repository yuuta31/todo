class TagForm
  include ActiveModel::Model

  def initialize(tag_list) = @tag_list = initialize_params_tag_list(tag_list)

  def tags = tag_list

  private

  attr_reader :tag_list

  def initialize_params_tag_list(tag_list)
    return [] if tag_list.count.zero?

    tag_list.inject([]) do |result, name|
      tag_name = Tag.find_or_initialize_by(name: name)

      if tag_name&.valid? && tag_name.save
        result << tag_name.name
      else
        result
      end
    end
  end
end

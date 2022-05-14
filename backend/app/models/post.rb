class Post < ApplicationRecord
  has_many :post_tags, dependent: :destroy
end

class Like < ApplicationRecord
  belongs_to :likeble, polymorphic: true
end

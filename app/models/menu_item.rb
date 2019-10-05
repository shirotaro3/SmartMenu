class MenuItem < ApplicationRecord
    belongs_to :item_group
    attachment :item_image, type: :image
    acts_as_list :scope => :item_group
    validates :item_name, presence: true, length: { maximum: 10 }
    validates :price, presence: true,length: { maximum: 6 }
    default_scope -> { order("position ASC") }
end

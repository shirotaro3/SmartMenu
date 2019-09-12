class MenuItem < ApplicationRecord
    belongs_to :item_group
    attachment :item_image
    acts_as_list :scope => :item_group
    default_scope -> { order("position ASC") }

    validates :item_name, presence: true, length: { in: 2..10 }
    validates :price, presence: true,length: { in: 1..6 }
end

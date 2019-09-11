class ItemGroup < ApplicationRecord
    belongs_to :category
    belongs_to :menu
    validates :category_id, presence: true
    has_many :menu_items
    attachment :group_image
    acts_as_list :scope => :menu
    default_scope -> { order("position ASC") }
end

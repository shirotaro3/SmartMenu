class ItemGroup < ApplicationRecord
    belongs_to :category
    belongs_to :menu
    has_many :menu_items, dependent: :destroy
    attachment :group_image, type: :image
    acts_as_list :scope => :menu
    validates :category_id, presence: true
    default_scope -> { order("position ASC") }
end

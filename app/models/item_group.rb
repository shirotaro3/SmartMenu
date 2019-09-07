class ItemGroup < ApplicationRecord
    belongs_to :category
    belongs_to :menu
    has_many :menu_items
    attachment :group_image
end

class MenuItem < ApplicationRecord
    has_many :grins
    has_many :happies
    has_many :dizzies
    belongs_to :item_group
    attachment :item_image
    acts_as_list :scope => :item_group
    default_scope -> { order("position ASC") }
end

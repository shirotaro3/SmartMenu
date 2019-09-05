class MenuItem < ApplicationRecord
    has_many :grins
    has_many :happies
    has_many :dizzies
    belongs_to :category
    belongs_to :menu
end

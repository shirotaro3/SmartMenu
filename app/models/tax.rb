class Tax < ApplicationRecord
    
    validates :rate, :numericality => { :less_than => 1.0 }
end

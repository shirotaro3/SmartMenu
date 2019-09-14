class Tax < ApplicationRecord
    
    validates :rate, :numericality => { :greater_than => 1.0,:less_than=> 10.0 }
end

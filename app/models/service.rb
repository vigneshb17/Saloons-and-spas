class Service < ApplicationRecord
  belongs_to :saloon

  enum service_type: { 'hair_cut': 1, 'shaving': 2 }
end

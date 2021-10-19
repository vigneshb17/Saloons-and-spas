class Saloon < ApplicationRecord
  has_many :chairs, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :bookings, dependent: :destroy

  after_create :create_chairs, if: -> { total_chairs_count > 0 }

  private

  def create_chairs
    total_chairs_count.times do
      self.chairs.create!(available: 'yes')
    end
  end
end

class Booking < ApplicationRecord
  belongs_to :chair
  belongs_to :saloon
  belongs_to :service
  belongs_to :customer

  validates_presence_of :from_time, :to_time, :booking_date
  validate :check_from_time_format, if: -> { from_time.present? }

  enum status: { 'booked': 1, 'ongoing': 2, 'completed': 3, 'cancelled': 4 }

  private

  def check_from_time_format
    from_time_minutes = from_time.strftime('%I:%M %p').split(' ').first.split(':').last.to_i
    return if (from_time_minutes % 15) == 0

    errors.add(:from_time, 'from time should start on 0th, 15th, 30th or 45th minute of the hour')
  end
end

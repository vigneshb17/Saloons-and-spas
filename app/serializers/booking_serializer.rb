class BookingSerializer < ActiveModel::Serializer
  attributes :id, :from_time, :to_time, :booking_date, :status

  belongs_to :saloon
  belongs_to :chair
  belongs_to :customer
  belongs_to :service
end
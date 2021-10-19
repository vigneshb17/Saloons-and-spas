class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :service_type, :price, :timings_in_mins, :created_at, :updated_at

  belongs_to :saloon
end
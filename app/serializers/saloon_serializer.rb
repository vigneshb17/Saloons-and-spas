class SaloonSerializer < ActiveModel::Serializer
  attributes :id, :company_name, :GSTIN, :pan_number, :total_chairs_count, :available_chairs_count,
             :working_hours_from, :working_hours_to, :created_at, :updated_at
end
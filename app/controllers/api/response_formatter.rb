module Api
  module ResponseFormatter
    def serialized_data(data, include, each_serializer)
      options = { include: include }
      options[:each_serializer] = each_serializer

      ActiveModelSerializers::SerializableResource.new(data, options)
    end

    def render_success(data: nil, message: nil, include: nil, each_serializer: nil, additional_attributes: {})
      resp_data = { status: 'success' }
      resp_data[:message] = message if message

      # Serialize the resource
      resp_data[:data] = serialized_data(data, include, each_serializer) if data

      render json: resp_data.merge(additional_attributes), status: 200
    end

    def render_error(status, message)
      render json: { status: 'error', message: message }, status: status
    end
  end
end
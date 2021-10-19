module Api
  class SaloonsController < ApplicationController
    before_action :set_saloon, except: :index

    # method: get, url: /api/saloons?per_page=10&page=1
    #
    def index
      params[:page] ||= 1
      params[:per_page] ||= 10

      saloons = Saloon.all.paginate(page: params[:page], per_page: params[:per_page])

      render_success(data: saloons, each_serializer: SaloonSerializer)
    end

    # method: get, url: /api/saloons/:id/services
    #
    def services
      services = @saloon.services

      render_success(data: services, each_serializer: ServiceSerializer)
    end

    # method: post, url: /api/saloons/:id/book_service
    # {
    #     "booking": {
    #         "from_time": "11:00",
    #         "to_time": "12:00",
    #         "booking_date": "2021-10-14",
    #         "service_id": 4,
    #         "chair_id": 1
    #     }
    # }
    #
    def book_service
      booking = @saloon.bookings.new(bookings_params)

      if booking.save
        render_success(data: booking, each_serializer: BookingSerializer)
      else
        render_error(422, booking.errors)
      end
    end

    # method: get, url: /api/saloons/:id/booking_reports
    #
    def booking_reports
      bookings = @saloon.bookings.includes(:service, :chair, :customer)
                     .where("booking_date >= ? and booking_date <= ?", 1.month.ago.to_date, Time.now.to_date)

      total_revenue_earned = bookings.where.not(status: 'cancelled').sum('services.price')
      total_revenue_lost = bookings.where(status: 'cancelled').sum('services.price')

      render_success(data: bookings, each_serializer: BookingSerializer,
                     additional_attributes: { total_revenue_earned: total_revenue_earned, total_revenue_lost: total_revenue_lost })
    end

    private

    def set_saloon
      @saloon = Saloon.find_by(id: params[:id])

      render_error(404, "Couldn't find Saloon by given ID") unless @saloon
    end

    def bookings_params
      params.require(:booking).permit(:from_time, :to_time, :booking_date, :status,
                                      :chair_id, :service_id).merge!(customer_id: current_customer.id, status: 'booked')
    end
  end
end
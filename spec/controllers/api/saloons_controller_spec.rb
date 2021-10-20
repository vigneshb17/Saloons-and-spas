require 'rails_helper'

RSpec.describe Api::SaloonsController, type: :controller do

  before :each, login_customer: true do
    @request.env["devise.mapping"] = Devise.mappings[:customer]
    @customer = FactoryBot.create(:customer)
    subject.sign_in @customer
  end

  let(:create_saloons) do
    @saloons = FactoryBot.create_list(:saloons, 10)
  end

  describe 'GET #index' do
    context 'with invalid params' do
      it 'returns - unauthorised' do
        get :index, format: :json

        expect(response).to have_http_status(401)
      end
    end

    context 'with valid params', login_customer: true do
      it 'returns http status success' do
        get :index, format: :json

        expect(response).to have_http_status(200)
      end

      it 'returns data count is 5' do
        create_saloons
        get :index, params: { per_page: 5, page: 1 }, format: :json

        expect(JSON.parse(response.body)['data'].count).to eql 5
      end
    end
  end

  describe 'GET #services' do
    context 'with invalid params' do
      it 'returns - unauthorised' do
        get :services, params: { id: 1 }, format: :json

        expect(response).to have_http_status(401)
      end

      it 'returns - error message', login_customer: true do
        get :services, params: { id: 1 }, format: :json

        expect(JSON.parse(response.body)['message']).to eql "Couldn't find Saloon by given ID"
      end
    end

    context 'with valid params', login_customer: true do
      before(:each) do
        @saloon = FactoryBot.create(:saloon)
        @service = FactoryBot.create(:hair_cut_service, saloon_id: @saloon.id)
      end

      it 'returns http status success' do
        get :services, params: { id: @saloon.id }, format: :json

        expect(response).to have_http_status(200)
      end

      it 'returns data count is 1' do
        get :services, params: { id: @saloon.id }, format: :json

        expect(JSON.parse(response.body)['data'].count).to eql 1
      end
    end
  end

  describe 'POST #book_service' do
    context 'with invalid params' do
      it 'returns - unauthorised' do
        post :book_service, params: { id: 1 }, format: :json

        expect(response).to have_http_status(401)
      end

      it 'returns - error message', login_customer: true do
        post :book_service, params: { id: 1 }, format: :json

        expect(JSON.parse(response.body)['message']).to eql "Couldn't find Saloon by given ID"
      end
    end

    context 'with valid params', login_customer: true do
      before(:each) do
        @saloon = FactoryBot.create(:saloon)
        @service = FactoryBot.create(:hair_cut_service, saloon_id: @saloon.id)
        @chair = FactoryBot.create(:chair, saloon_id: @saloon.id)
      end

      it 'returns http status success' do
        post :book_service, params: { id: @saloon.id, booking: { "from_time": "11:00", "to_time": "12:00", "booking_date": "2021-10-14",
                                                                 service_id: @service.id, chair_id: @chair.id } }, format: :json

        expect(response).to have_http_status(200)
      end

      it 'returns data count is 1' do
        get :services, params: { id: @saloon.id }, format: :json

        expect(JSON.parse(response.body)['data'].count).to eql 1
      end
    end
  end

  describe 'GET #booking_reports' do
    context 'with invalid params' do
      it 'returns - unauthorised' do
        get :booking_reports, params: { id: 1 }, format: :json

        expect(response).to have_http_status(401)
      end

      it 'returns - error message', login_customer: true do
        get :booking_reports, params: { id: 1 }, format: :json

        expect(JSON.parse(response.body)['message']).to eql "Couldn't find Saloon by given ID"
      end
    end

    context 'with valid params', login_customer: true do
      before(:each) do
        @saloon = FactoryBot.create(:saloon)
        @service = FactoryBot.create(:hair_cut_service, saloon_id: @saloon.id)
        @chair = FactoryBot.create(:chair, saloon_id: @saloon.id)
        @booking = Booking.create(from_time: "11:00", to_time: "12:00", booking_date: "2021-10-20",
                                  service_id: @service.id, chair_id: @chair.id, status: 'booked',
                                  customer_id: @customer.id, saloon_id: @saloon.id)
      end

      it 'returns http status success' do
        get :booking_reports, params: { id: @saloon.id }, format: :json

        expect(response).to have_http_status(200)
      end

      it 'returns expected data' do
        get :booking_reports, params: { id: @saloon.id }, format: :json

        expect(JSON.parse(response.body)['data'].count).to eql 1
        expect(JSON.parse(response.body)['total_revenue_earned']).to eql 100
        expect(JSON.parse(response.body)['total_revenue_lost']).to eql 0
      end
    end
  end

end

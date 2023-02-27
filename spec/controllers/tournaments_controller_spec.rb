require 'rails_helper'

RSpec.describe TournamentsController, type: :controller do
  describe 'POST create' do
    context 'with valid name param' do
      let(:request_body) do
        {
          name: 'Tournament'
        }
      end

      it 'returns status created' do
        post :create, params: { tournament: request_body }, format: :json

        expect(response).to be_created
      end
    end

    context 'with invalid name param' do
      let(:request_body) do
        {
          name: nil
        }
      end

      it 'returns status bad request' do
        post :create, params: { tournament: request_body }, format: :json

        expect(response).to be_bad_request
      end
    end
  end
end

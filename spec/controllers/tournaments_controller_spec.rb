require 'rails_helper'

RSpec.describe TournamentsController, type: :controller do

  let(:response_body) { JSON.parse(response.body, symbolize_names: true) }

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

  describe 'GET index' do
    render_views

    it 'returns status ok' do
      get :index, format: :json

      expect(response).to be_ok
    end

    let(:tournament) { build(:tournament) }
    let(:tournaments) { [tournament] }

    it 'assigns @tournaments' do
      expect(Tournament).to receive_message_chain(:all, :includes).and_return(tournaments)

      get :index, format: :json

      expect(assigns(:tournaments)).to eq(tournaments)
    end

    let(:tournament) { build(:tournament) }
    let(:tournaments) { [tournament] }
    let(:expected_body) do
      [{
        id: tournament.id,
        name: tournament.name,
        races: []
      }]
    end

    it 'returns tournaments' do
      expect(Tournament).to receive_message_chain(:all, :includes).and_return(tournaments)
      
      get :index, format: :json

      expect(response_body).to eq(expected_body)
    end
  end
end

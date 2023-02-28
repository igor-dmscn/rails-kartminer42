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

  describe 'GET show' do
    render_views

    context 'when tournament exists' do

      let(:tournament) { build(:tournament) }

      it 'returns status ok' do
        expect(Tournament).to receive(:find).and_return(tournament)

        get :show, params: { id: 1 }, format: :json

        expect(response).to be_ok
      end

      let(:tournament) { build(:tournament) }

      it 'assigns @tournament' do
        expect(Tournament).to receive(:find).and_return(tournament)

        get :show, params: { id: 1 }, format: :json

        expect(assigns(:tournament)).to eq(tournament)
      end

      let(:tournament) { build(:tournament) }
      let(:racers) { build_list(:racer, 3) }

      it 'assigns @racers' do
        expect(Tournament).to receive(:find).and_return(tournament)
        expect(Racer).to receive(:from_tournament).and_return(racers)

        get :show, params: { id: 1 }, format: :json

        expect(assigns(:racers)).to eq(racers)
      end

      let(:tournament) { build_stubbed(:tournament, :with_races) }
      let(:racer) { build_stubbed(:racer) }
      let(:racers) { [racer] }
      let(:expected_body) do
        {
          id: tournament.id,
          name: tournament.name,
          racers: [
            {
              id: racer.id,
              name: racer.name,
              born_at: racer.born_at.to_s,
              image_url: racer.image_url,
              points: 5
            }
          ]
        }
      end

      it 'returns tournament with given id' do
        expect(Tournament).to receive(:find).and_return(tournament)
        expect(Racer).to receive(:from_tournament).and_return(racers)
        expect(racer).to receive(:points_from_tournament).and_return(5)

        get :show, params: { id: tournament.id }, format: :json

        expect(response_body).to eq(expected_body)
      end
    end

    context 'when tournament does not exists' do
      it 'returns status not found' do
        get :show, params: { id: 1 }, format: :json

        expect(response).to be_not_found
      end

      let(:expected_body) do
        {
          error: true,
          message: 'Not found'
        }
      end

      it 'returns not found error body' do
        get :show, params: { id: 1 }, format: :json

        expect(response_body).to eq(expected_body)
      end
    end
  end
end

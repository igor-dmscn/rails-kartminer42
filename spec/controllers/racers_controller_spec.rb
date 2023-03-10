require 'rails_helper'

RSpec.describe RacersController, type: :controller do

  let(:response_body) { JSON.parse(response.body, symbolize_names: true) }

  describe 'GET index' do
    render_views

    it 'returns status ok' do
      get :index, format: :json

      expect(response).to be_ok
    end

    let(:racer) { build(:racer) }
    let(:racers) { [racer] }

    it 'assigns @racers' do
      expect(Racer).to receive(:all).and_return(racers)

      get :index, format: :json

      expect(assigns(:racers)).to eq(racers)
    end

    let(:racer) { build(:racer) }
    let(:racers) { [racer] }
    let(:expected_body) do
      [{
          id: racer.id,
          name: racer.name,
          born_at: racer.born_at.to_s,
          image_url: racer.image_url
      }]
    end

    it 'returns racers as json' do
      expect(Racer).to receive(:all).and_return(racers)

      get :index, format: :json

      expect(response_body).to eq(expected_body)
    end
  end

  describe 'GET show' do
    render_views

    context 'when racer exists' do
      let(:racer) { build(:racer) }

      it 'returns status ok' do
        expect(Racer).to receive(:find).and_return(racer)

        get :show, params: { id: 1 }, format: :json

        expect(response).to be_ok
      end

      let(:racer) { build(:racer) }

      it 'assigns @racer' do
        expect(Racer).to receive(:find).and_return(racer)

        get :show, params: { id: 1 }, format: :json

        expect(assigns(:racer)).to eq(racer)
      end

      let(:racer) { build(:racer) }
      let(:expected_body) do
        {
          id: racer.id,
          name: racer.name,
          born_at: racer.born_at.to_s,
          image_url: racer.image_url
        }
      end

      it 'returns racer as json' do
        expect(Racer).to receive(:find).and_return(racer)

        get :show, params: { id: 1 }, format: :json

        expect(response_body).to eq(expected_body)
      end
    end

    context 'when racer does not exists' do
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

  describe 'POST create' do
    context 'with all request body params' do
      let(:request_body) do
        {
          name: 'Racer',
          born_at: (Racer::MIN_AGE + 1).years.ago,
          image_url: 'http://example.org'
        }
      end

      it 'returns status created' do
        post :create, params: { racer: request_body }, format: :json

        expect(response).to be_created
      end
    end

    context 'without request body name param' do
      let(:request_body) do
        {
          born_at: (Racer::MIN_AGE + 1).years.ago,
          image_url: 'http://example.org'
        }
      end

      it 'returns status bad request' do
        post :create, params: { racer: request_body }, format: :json

        expect(response).to be_bad_request
      end
    end

    context 'without request body born_at param' do
      let(:request_body) do
        {
          name: 'Racer',
          image_url: 'http://example.org'
        }
      end

      it 'returns status bad request' do
        post :create, params: { racer: request_body }, format: :json

        expect(response).to be_bad_request
      end
    end

    context 'with invalid request body born_at param' do
      let(:request_body) do
        {
          name: 'Racer',
          born_at: 1,
          image_url: 'http://example.org'
        }
      end

      it 'returns status bad request' do
        post :create, params: { racer: request_body }, format: :json

        expect(response).to be_bad_request
      end
    end

    context 'with invalid request body image_url param' do
      let(:request_body) do
        {
          name: 'Racer',
          born_at: (Racer::MIN_AGE + 1).years.ago,
          image_url: 'image.jpg'
        }
      end

      it 'returns status bad request' do
        post :create, params: { racer: request_body }, format: :json

        expect(response).to be_bad_request
      end
    end
  end

  describe 'PATCH update' do
    context 'when racer exists' do
      let(:racer) { build(:racer, :with_id) }
      
      context 'with all request body params' do
        let(:request_body) do
          {
            name: 'Racer',
            born_at: (Racer::MIN_AGE + 1).years.ago,
            image_url: 'http://example.org'
          }
        end
  
        it 'returns status ok' do
          expect(Racer).to receive(:find).and_return(racer)

          patch :update, params: { id: racer.id, racer: request_body }, format: :json
  
          expect(response).to be_ok
        end
      end
  
      context 'without request body name param' do
        let(:request_body) do
          {
            born_at: (Racer::MIN_AGE + 1).years.ago,
            image_url: 'http://example.org'
          }
        end
  
        it 'returns status ok' do
          expect(Racer).to receive(:find).and_return(racer)

          patch :update, params: { id: racer.id, racer: request_body }, format: :json
  
          expect(response).to be_ok
        end
      end
  
      context 'without request body born_at param' do
        let(:request_body) do
          {
            name: 'Racer',
            image_url: 'http://example.org'
          }
        end
  
        it 'returns status ok' do
          expect(Racer).to receive(:find).and_return(racer)
          
          patch :update, params: { id: racer.id, racer: request_body }, format: :json
  
          expect(response).to be_ok
        end
      end
  
      context 'with invalid request body born_at param' do
        let(:request_body) do
          {
            name: 'Racer',
            born_at: 1
          }
        end
  
        it 'returns status bad request' do
          expect(Racer).to receive(:find).and_return(racer)
          
          patch :update, params: { id: racer.id, racer: request_body }, format: :json
  
          expect(response).to be_bad_request
        end
      end
  
      context 'with invalid request body image_url param' do
        let(:request_body) do
          {
            name: 'Racer',
            born_at: (Racer::MIN_AGE + 1).years.ago,
            image_url: 'image.jpg'
          }
        end
  
        it 'returns status bad request' do
          expect(Racer).to receive(:find).and_return(racer)
          
          patch :update, params: { id: racer.id, racer: request_body }, format: :json
  
          expect(response).to be_bad_request
        end
      end
    end

    context 'when racer does not exists' do
      it 'returns status not found' do
        patch :update, params: { id: 1 }, format: :json

        expect(response).to be_not_found
      end

      let(:expected_body) do
        {
          error: true,
          message: 'Not found'
        }
      end

      it 'returns not found error body' do
        patch :update, params: { id: 1 }, format: :json

        expect(response_body).to eq(expected_body)
      end
    end
  end

  describe 'DELETE delete' do
    context 'when racer exists' do
      let(:racer) { build(:racer, :with_id) }

      it 'returns status ok' do
        expect(Racer).to receive(:find).and_return(racer)

        delete :destroy, params: { id: racer.id }, format: :json

        expect(response).to be_ok
      end
    end

    context 'when racer does not exists' do
      it 'returns status not found' do
        delete :destroy, params: { id: 1 }, format: :json

        expect(response).to be_not_found
      end

      let(:expected_body) do
        {
          error: true,
          message: 'Not found'
        }
      end

      it 'returns not found error body' do
        delete :destroy, params: { id: 1 }, format: :json

        expect(response_body).to eq(expected_body)
      end
    end
  end
end

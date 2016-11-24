require 'rails_helper'

RSpec.describe CompassController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET checkin" do
    let(:student)   { create(:student) }
    let(:location1) { create(:location) }
    let(:location2) { create(:location) }

    before {
      allow(request.env['warden']).to receive(:authenticate!).and_return(student)
      allow(controller).to receive(:current_user).and_return(student)
    }

    context "incorrect location for scanning" do
      let(:query)     { -> { student.scans.where(correct: false).count } }
      let(:event)     { create(:event, user_id: student.id, location: location1) }

      it "creates a new scan with incorrect status and redirects to compass" do
        command = -> { get :checkin, params: { event_id: event.id, scanned_data: location2.id } }
        expect { command.call }.to change { query.call }.by(1)

        expect(response).to redirect_to(compass_path)
      end

      it "is resilient enough to work when no location for the event is known" do
        google_event = create(:event, user_id: student.id, location: nil)
        command = -> { get :checkin, params: { event_id: google_event.id, scanned_data: location2.id } }
        expect { command.call }.to change { query.call }.by(1)
      end
    end


    context "correct location for scanning" do
      let(:query) { -> { student.scans.where(correct: true).count } }
      let(:event) { create(:event, user_id: student.id, location: location1) }

      it "creates a new scan with correct status and redirects to compass" do
        command = -> { get :checkin, params: { event_id: event.id, scanned_data: location1.id } }
        expect { command.call }.to change { query.call }.by(1)

        expect(response).to redirect_to(compass_path)
      end

    end

  end
end

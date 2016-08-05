require 'rails_helper'

RSpec.describe CompassController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET checkin" do
    context "incorrect location for scanning" do
      it "creates a new scan with incorrect status and redirects to compass" do
        student = create(:student)
        location1 = create(:location)
        location2 = create(:location)
        allow(request.env['warden']).to receive(:authenticate!).and_return(student)
        allow(controller).to receive(:current_user).and_return(student)
        expect {
          get :checkin, location_id: location1.id, scanned_data: location2.id
        }.to change {
          student.scans.where(correct: false).count
        }.by 1

        expect(response).to redirect_to(compass_path)
      end

      context "correct location for scanning" do
        it "creates a new scan with correct status and redirects to compass" do
          student = create(:student)
          location1 = create(:location)
          allow(request.env['warden']).to receive(:authenticate!).and_return(student)
          allow(controller).to receive(:current_user).and_return(student)
          expect {
            get :checkin, location_id: location1.id, scanned_data: location1.id
          }.to change {
            student.scans.where(correct: true).count
          }.by 1

          expect(response).to redirect_to(compass_path)
        end
      end
    end
  end
end

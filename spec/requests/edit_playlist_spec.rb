require 'rails_helper'

describe "PATCH api/v1/admin/playlist_activities/:id" do
  let(:grove) { create(:grove_with_resources) }
  let(:teacher) { grove.teachers.first }
  let(:student) { grove.students.first }
  let(:playlist_activity) { student.playlist_activities.first }

  it "can update the position priority of the activities for a specific student " do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(teacher)

    data = { positions: { (playlist_activity.id.to_s) => "1" },
             id: student.id }

    expect(playlist_activity.position).to eq nil

    patch api_v1_admin_playlist_activity_path(playlist_activity.id), { data: data }

    expect(response.status).to eq 204

    expect(student.playlist_activities.first.position).to eq 1
  end
end

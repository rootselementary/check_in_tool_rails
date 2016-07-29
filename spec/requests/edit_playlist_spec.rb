require 'rails_helper'

describe "PATCH api/v1/admin/playlist_activities/:id" do 
  let(:grove) { create(:grove_with_resources) }
  let(:student) { grove.students.first } 
  let(:playlist_activity) { student.playlist_activities.first }
  let(:playlist_activity2) { student.playlist_activities.last }

  it "can update the position priority of the activities for a specific student " do 
    data = { activities: { (playlist_activity.id.to_s) => "0",
                          (playlist_activity2.id.to_s) => "1", 
                        },
             student_id: student.id
            }
                                    
    expect(playlist_activity.position).to eq nil
    expect(playlist_activity2.position).to eq nil

    patch api_v1_admin_playlist_activity_path(1), { data: data }

    expect(response.status).to eq 204

    expect(student.playlist_activities.first.position).to eq 0
    expect(student.playlist_activities.last.position).to eq 1
  end  
end 


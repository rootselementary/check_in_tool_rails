require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should have_many :playlist_activities }
  it { should have_many :events }

  describe '#students' do
    let(:grove) { create(:grove_with_resources) }
    let(:student) { grove.students.last }
    let(:activity1) { create(:activity, title: "new activity") }
    let(:activity2) { create(:activity, title: "newer activity") }


    describe '#absent' do
      it 'returns all absent students' do
        student.update(at_school: false)

        absent_students = Student.absent

        expect(absent_students.size).to eq(1)
      end
    end

    describe '#lost' do
      it 'returns all students without a scheduled event' do
        grove
        Scan.delete_all
        Event.delete_all

        lost_students = Student.lost

        expect(lost_students.count).to eq(2)
      end
    end

    describe '#last_activity' do

      it 'finds the last activity based on the last activity scan' do
        scan1 = create(:scan, student: student, activity: activity2, created_at: 1.hour.ago)
        scan2 = create(:scan, student: student, activity: activity1, created_at: 15.minutes.ago)
        expect(student.last_activity).to eq(activity1)
      end

      it 'does not blow up if there are no scans' do
        expect(student.last_activity).to eq(nil)
      end
    end

    describe '#rotated_playlist' do
      before { student.last_activity_id = nil }
      let(:student) { create(:student, playlist_activities: [ build(:playlist_activity, position: 1,
                                                                                        activity: activity1),
                                                              build(:playlist_activity, position: 2,
                                                                                        activity: activity2)
                                                            ]) }
      it 'rotates playlist activities based on last activity from previous day' do
        expect(student.rotated_playlist.map(&:position)).to eq([1, 2])
        activity = student.playlist_activities.joins(:activity).where('activities.title = ?', "newer activity").first
        student.last_activity_id = activity.activity.id
        expect(student.rotated_playlist.map(&:position)).to eq([2, 1])
      end
    end
  end
end

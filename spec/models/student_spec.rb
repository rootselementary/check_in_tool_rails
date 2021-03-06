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
      before { @grove = create(:grove_with_scanned_in_students) }
      let(:query) { -> { Student.lost } }
      let(:student) { @grove.students.first }

      it 'has no lost students' do
        expect(query.call.count).to eq(0)
      end

      it 'returns all students without a scan' do
        student.scans.destroy_all
        expect(query.call).to eq([student])
      end

      it 'returns all students where a scan is in the past' do
        student.scans.destroy_all
        student.scans.create(:expires_at => 1.minute.ago)
        expect(query.call).to eq([student])
      end
    end

    describe '#compass_events' do

      # before { Timecop.freeze(Time.parse('2016-08-05 08:45:00 -0600')) }
      after { Timecop.return }

      it 'at the start of the next event' do
        Timecop.freeze(Time.parse('2016-08-05 08:45:01 -0600'))
        before = create(:event, start_time: Time.parse('2016-08-05 08:00:00 -0600'), end_time: Time.parse('2016-08-05 08:45:00 -0600'), student: student)
        event1 = create(:event, start_time: Time.parse('2016-08-05 08:45:00 -0600'), end_time: Time.parse('2016-08-05 09:00:00 -0600'), student: student)
        event2 = create(:event, start_time: Time.parse('2016-08-05 09:00:00 -0600'), end_time: Time.parse('2016-08-05 09:15:00 -0600'), student: student)
        after = create(:event, start_time: Time.parse('2016-08-05 09:15:00 -0600'), end_time: Time.parse('2016-08-05 09:30:00 -0600') , student: student)

        expect(student.compass_events).to eq([event1, event2])
      end

      it 'can capture partway through an event' do
        Timecop.freeze(Time.parse('2016-08-05 08:45:00 -0600'))
        before = create(:event, start_time: Time.parse('2016-08-05 08:00:00 -0600'), end_time: Time.parse('2016-08-05 08:30:00 -0600'), student: student)
        event1 = create(:event, start_time: Time.parse('2016-08-05 08:30:00 -0600'), end_time: Time.parse('2016-08-05 09:00:00 -0600'), student: student)
        event2 = create(:event, start_time: Time.parse('2016-08-05 09:00:00 -0600'), end_time: Time.parse('2016-08-05 09:15:00 -0600'), student: student)
        after = create(:event, start_time: Time.parse('2016-08-05 09:15:00 -0600'), end_time: Time.parse('2016-08-05 09:30:00 -0600') , student: student)

        expect(student.compass_events).to eq([event1, event2])
      end

      it 'shows the next event first during grove transition' do
        Timecop.freeze(Time.parse('2016-08-05 08:28:30 -0600'))
        before = create(:event, start_time: Time.parse('2016-08-05 08:00:00 -0600'), end_time: Time.parse('2016-08-05 08:30:00 -0600'), student: student)
        event1 = create(:event, start_time: Time.parse('2016-08-05 08:30:00 -0600'), end_time: Time.parse('2016-08-05 09:00:00 -0600'), student: student)
        event2 = create(:event, start_time: Time.parse('2016-08-05 09:00:00 -0600'), end_time: Time.parse('2016-08-05 09:15:00 -0600'), student: student)
        after = create(:event, start_time: Time.parse('2016-08-05 09:15:00 -0600'), end_time: Time.parse('2016-08-05 09:30:00 -0600') , student: student)

        expect(student.compass_events).to eq([event1, event2])
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

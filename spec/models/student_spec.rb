require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should have_many :playlist_activities }
  it { should have_many :events }

  describe '#students' do
    let(:grove) { create(:grove_with_resources) }
    let(:student) { grove.students.last }


    describe '#absent' do
      it 'returns all absent students' do
        student.update(at_school: false)

        absent_students = Student.absent

        expect(absent_students.size).to eq(1)
      end
    end

    describe '#lost' do
      let(:student1) { grove.students.first }
      let(:student2) { grove.students.last }
      let(:event) { student1.events.first }
      let(:event2) { student2.events.first }
      let(:scan) { event.scans.first }
      let(:scan2) { event2.scans.last }
      let(:location) { create(:location) }

      it 'returns all lost students' do
        event.update(student: student1, location: location)
        scan2.update(correct: false)
        event2.update(student: student2, location: location)

        lost_students = Student.lost

        expect(lost_students.size).to eq(2)
      end
    end
  end
end

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
      it 'returns all students without a scheduled event' do
        grove
        Scan.delete_all
        Event.delete_all

        lost_students = Student.lost

        expect(lost_students.count).to eq(2)
      end
    end
  end
end

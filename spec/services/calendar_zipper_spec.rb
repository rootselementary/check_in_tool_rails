require 'rails_helper'

RSpec.describe CalendarZipper do

  before { Timecop.freeze }
  after { Timecop.return }

  let(:master_schedule) {
    [[8, 0], [8, 45], [9, 30], [10, 15], [11, 00]]
  }

  let(:playlist) {
    [
      { name: "coloring"},
      { name: "drawing" },
      { name: "reading" },
      { name: "geometry" },
      { name: "addition" },
      { name: "subtraction" }
    ]
  }

  describe '#schedule' do

    describe 'when things line up nicely' do
      let(:master_schedule) {
        [[8, 0], [8, 45], [9, 30], [10, 15]]
      }

      it 'provides a sequential list of activities' do
        activities = [
          { name: 'english 101', start_time: Time.zone.now.change(hour: 8, min: 00), end_time: Time.zone.now.change(hour: 8, min: 45) }
        ]
        schedule = described_class.new(master_schedule, activities, playlist).schedule
        expect(schedule).to eq([
                                  {name: 'english 101', duration: 2700},
                                  {name: 'coloring', duration: 900},
                                  {name: 'drawing', duration: 900},
                                  {name: 'reading', duration: 900},
                                  { name: "geometry", duration: 900 },
                                  { name: "addition", duration: 900 },
                                  { name: "subtraction", duration: 900 }
                               ])
      end

      it 'can handle a scheduled event in the middle of the day' do
        activities = [
          { name: 'english 101', start_time: Time.zone.now.change(hour: 8, min: 45), end_time: Time.zone.now.change(hour: 9, min: 30) }
        ]
        schedule = described_class.new(master_schedule, activities, playlist).schedule
        expect(schedule).to eq([
                                 {name: 'coloring', duration: 900},
                                 {name: 'drawing', duration: 900},
                                 {name: 'reading', duration: 900},
                                 {name: 'english 101', duration: 2700},
                                 { name: "geometry", duration: 900 },
                                 { name: "addition", duration: 900 },
                                 { name: "subtraction", duration: 900 }
                               ])
      end

      xit 'can handle a scheduled event in the middle of the period' do
        activities = [
          { name: 'english 101', start_time: Time.zone.now.change(hour: 8, min: 15), end_time: Time.zone.now.change(hour: 8, min: 45) }
        ]
        schedule = described_class.new(master_schedule, activities, playlist).schedule
        expect(schedule).to eq([
                                 {name: 'coloring', duration: 900},
                                 {name: 'english 101', duration: 2700},
                                 {name: 'drawing', duration: 900},
                                 {name: 'reading', duration: 900},
                                 { name: "geometry", duration: 900 },
                                 { name: "addition", duration: 900 },
                                 { name: "subtraction", duration: 900 }
                               ])
      end
    end
  end

  describe 'functional helpers' do
    subject { described_class.new([], [], []) }
    describe '#to_time' do
      it 'converts a tuple to a time object' do
        expect(subject.to_time([8, 30]).hour).to eq(8)
        expect(subject.to_time([8, 30]).min).to eq(30)
      end
    end

    describe '#to_range' do
      it 'converts a set of tuples to a time range' do
        time = Time.zone.now.change(hour: 8, min: 55)
        expect(subject.to_range([8, 30], [9, 15])).to cover(time)
      end
    end

    describe '#relevant_activities' do
      it 'plucks relevant activities from the activites list' do
        activities = [
          { name: 'english 101', start_time: Time.zone.now.change(hour: 8, min: 0), end_time: Time.zone.now.change(hour: 8, min: 45) },
          { name: 'english 101', start_time: Time.zone.now.change(hour: 9, min: 45), end_time: Time.zone.now.change(hour: 10, min: 30) },
        ]

        expect(subject.relevant_activities(activities, [8, 0], [9, 15]).count).to eq(1)
      end
    end

    describe '#apply_activities' do

      describe 'with an empty schedule' do

        let(:schedule) { [] }

        it 'applies to the start of the schedule when the start time matches the beginning of the period' do
          activities = [
            { name: 'english 101', start_time: Time.zone.now.change(hour: 8, min: 0), end_time: Time.zone.now.change(hour: 8, min: 45) }
          ]
          s = subject.apply_activities(schedule, activities)
          expect(s).to eq([{name: 'english 101', duration: 2700}])
        end
      end

      describe 'with a partial schedule' do
        activities = [
          { name: 'math 101', start_time: Time.zone.now.change(hour: 8, min: 45), end_time: Time.zone.now.change(hour: 9, min: 15) }
        ]
        let(:schedule) { [name: 'english 101', duration: 2700] }
        it 'fills in after the existing scheduled items' do
          s = subject.apply_activities(schedule, activities)
          expect(s).to eq([{name: 'english 101', duration: 2700}, {name: 'math 101', duration: 1800}])
        end
      end
    end
  end


#   it 'does something' do
#     activties = [
#       {:name => 'english 101', :start_time => [8, 45], :end_time => [9, 30]}
#     ]
#   end
#   schedule = CalendarZipper.new(master_schedule, activties, playlist).schedule
#   expect(schedule).to eq([
#                             {name: "coloring", duration: 15}, # 8am
#                             {name: "drawing", duration: 15},
#                             {name: "reading", duration: 15},
#                             {name: 'english 101', duration: 2580, starts_at: datetime},# 8:45 - 9:30 AM
#                             {name: 'geometry', duration: 15},
#                             {name: 'addition', duration: 15},
#                             {name: 'subtraction', duration: 15}, # 10:15 AM
#                             {name: 'coloring', duration: 15},
#                             {name: 'drawing', duration: 15},
#                             {name: 'reading', duration: 15} # 11:00 AM
#                          ])
#
end

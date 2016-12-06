require 'rails_helper'

RSpec.describe CalendarZipper do

  before { Timecop.freeze }
  after { Timecop.return }

  let(:playlist) {
    [
      { name: "coloring" },
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
        [[8, 0], [11, 0]]
      }
      let(:english) {
        { name: 'english-101', start_time: Time.zone.now.change(hour: 8, min: 00), end_time: Time.zone.now.change(hour: 8, min: 45) }
      }
      let(:math) {
        { name: 'math-101', start_time: Time.zone.now.change(hour: 9, min: 30), end_time: Time.zone.now.change(hour: 10, min: 15) }
      }

      describe 'where there are no activities' do
        it 'fills the schedule with playlist activities' do
          activities = []
          schedule   = described_class.new(master_schedule, activities, playlist).schedule
          expect(daily_schedule(schedule)).to eq(%w(coloring drawing reading geometry addition subtraction coloring drawing reading geometry addition subtraction))
        end
      end

      describe 'where there is one activity' do
        it 'wraps the activity in playlist items' do
          activities = [english]
          schedule   = described_class.new(master_schedule, activities, playlist).schedule
          expect(daily_schedule(schedule)).to eq(%w(english-101 coloring drawing reading geometry addition subtraction coloring drawing reading))
        end

        it 'can front load activities' do
          activity = english.merge(start_time: Time.zone.now.change(hour: 8, min: 30), end_time: Time.zone.now.change(hour: 9, min: 15))
          schedule = described_class.new(master_schedule, [activity], playlist).schedule
          expect(daily_schedule(schedule)).to eq(%w(coloring drawing english-101 reading geometry addition subtraction coloring drawing reading))
        end
      end

      describe 'when there is more than one activity' do
        it 'constructs the schedule accordingly' do
          activity = english.merge(start_time: Time.zone.now.change(hour: 8, min: 30), end_time: Time.zone.now.change(hour: 9, min: 15))
          schedule = described_class.new(master_schedule, [activity, math], playlist).schedule
          expect(daily_schedule(schedule)).to eq(%w(coloring drawing english-101 reading math-101 geometry addition subtraction))
        end

        it 'can fill the day with scheduled activities' do
          breakfast = { name: 'breakfast', start_time: Time.zone.now.change(hour: 8, min: 45), end_time: Time.zone.now.change(hour: 9, min: 30) }
          lunch     = { name: 'lunch', start_time: Time.zone.now.change(hour: 10, min: 15), end_time: Time.zone.now.change(hour: 11, min: 00) }
          schedule  = described_class.new(master_schedule, [english, breakfast, math, lunch], playlist).schedule

          expect(daily_schedule(schedule)).to eq(%w(english-101 breakfast math-101 lunch))
        end

        it 'handles lots of activities' do
          activity = english.merge(start_time: Time.zone.now.change(hour: 8, min: 30), end_time: Time.zone.now.change(hour: 9, min: 15))
          lunch    = { name: 'lunch', start_time: Time.zone.now.change(hour: 10, min: 30), end_time: Time.zone.now.change(hour: 10, min: 45) }
          schedule = described_class.new(master_schedule, [activity, math, lunch], playlist).schedule
          expect(daily_schedule(schedule)).to eq(%w(coloring drawing english-101 reading math-101 geometry lunch addition))
        end

        it 'handles lots n lots of activities' do
          breakfast = { name: 'breakfast', start_time: Time.zone.now.change(hour: 8, min: 0), end_time: Time.zone.now.change(hour: 8, min: 15) }
          activity  = english.merge(start_time: Time.zone.now.change(hour: 8, min: 30), end_time: Time.zone.now.change(hour: 9, min: 15))
          lunch     = { name: 'lunch', start_time: Time.zone.now.change(hour: 10, min: 30), end_time: Time.zone.now.change(hour: 10, min: 45) }
          schedule  = described_class.new(master_schedule, [breakfast, activity, math, lunch], playlist).schedule
          expect(daily_schedule(schedule)).to eq(%w(breakfast coloring english-101 drawing math-101 reading lunch geometry))
        end
      end

    end
  end

  def daily_schedule(schedule)
    schedule.map { |x| x[:name] }
  end

end

require 'rails_helper'

describe EventPresenter do
  subject { described_class.new(event) }

  describe '#left_panel - location panel' do

    describe 'when the location is known' do
      let(:location) { create(:location, name: "We know this one", )}
      let(:event) { create(:event, location: location) }

      it 'uses the name from the event record' do
        expect(subject.left_panel.content).to eq('We Know This One')
      end

      it 'uses the image provided by the location' do
        expect(subject.left_panel.image).to eq(location.image_url)
      end
    end

    describe 'when the location is not known (from google event)' do
      let(:event) { create(:event, location: nil, metadata: {location: "from google"}) }

      it 'uses the location string from the google event' do
        expect(subject.left_panel.content).to eq('From Google')
      end

      it 'does not try to set the image' do
        expect(subject.left_panel.image).to  be_nil
      end
    end
  end

  describe '#middle_panel' do

    describe 'image' do
      let(:activity) { create(:activity) }

      describe 'with an activity' do
        let(:event) { create(:event, title: nil, activity: activity) }

        it 'delegates to the activity' do
          expect(subject.middle_panel.image).to eq(activity.image_url)
        end
      end

      describe 'without an activity' do
        let(:event) { create(:event, title: 'foo', activity: nil) }

        it 'handles no activity' do
          expect(subject.middle_panel.image).to be_nil
        end
      end
    end

    describe 'content' do
      describe 'when the event has a title' do
        let(:event) { create(:event, title: 'event title') }

        it 'uses the event title' do
          expect(subject.middle_panel.content).to eq('Event Title')
        end
      end

      describe 'when the event does not have a title' do
        let(:event) { create(:event, title: nil, activity: create(:activity, title: 'activity title')) }

        it 'uses the activity title' do
          expect(subject.middle_panel.content).to eq('Activity Title')
        end
      end
    end

  end

  describe '#right_panel' do

    describe 'as scheduled event' do

    end

    describe 'as a recurring event (playlist activity)' do

      describe 'with a focus area' do
        let(:focus_area) { create(:focus_area, name: 'Target') }
        let(:activity) { create(:activity) }
        let(:event) { create(:event, activity: activity) }

        before { create(:playlist_activity, activity: activity, focus_area: focus_area) }

        it 'uses the image' do
          expect(subject.right_panel.image).to eq(focus_area.image_url)
        end

        it 'uses the focus area name' do
          expect(subject.right_panel.content).to eq(focus_area.name)
        end

      end

      describe 'without a focus area' do
        let(:activity) { create(:activity) }
        let(:event) { create(:event, activity: activity) }

        before { create(:playlist_activity, activity: activity, focus_area: nil) }

        it 'returns nil for image' do
          expect(subject.right_panel.image).to be_nil
        end

        it 'returns nil for content' do
          expect(subject.right_panel.content).to be_nil
        end
      end

    end

    describe 'as a scheduled event' do
      let(:teacher) { create(:teacher, google_image: 'https://lh5.googleusercontent.com/photo.jpg') }
      let(:activity) { create(:activity) }
      let(:event) { create(:event, activity: activity, creator: teacher) }

      before { create(:playlist_activity, activity: activity, focus_area: create(:focus_area)) }

      it "shows the creator's name" do
        expect(subject.right_panel.image).to eq(teacher.google_image)
      end

      it 'shows the image of the teacher (creator)' do
        expect(subject.right_panel.content).to eq(teacher.name)
      end


    end
  end
end

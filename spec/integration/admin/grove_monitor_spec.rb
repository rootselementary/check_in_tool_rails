require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Grove Monitor' do
  let(:grove)    { create(:grove_with_students) }
  let(:teacher)  { grove.teachers.first }
  let(:grove2)   { create(:grove_with_absent_students) }
  let(:teacher2) { grove2.teachers.first }

  let(:dashboard_page) { Pages::DashboardPage.new }

  describe 'as a teacher' do
    before { login(teacher) }

    let(:student1) { grove.students.first }
    let(:student2) { grove.students.last }
    let(:location) { create(:location) }
    let(:location2) { create(:location) }

    it 'can be reached from the main dashboard' do
      dashboard_page.click_on("Grove Monitor")
      expect(current_path).to eq(admin_grove_monitor_all_path)
    end

    it 'shows all students' do
      dashboard_page.click_on("Grove Monitor")
      expect(current_path).to eq(admin_grove_monitor_all_path)
      expect(page).to have_content(student1.name)
      expect(page).to have_content(student2.name)
    end


    it 'shows all absent students' do
      student1.update(at_school: false)
      absent_student = student1
      present_student = student2
      dashboard_page.click_on("Grove Monitor")
      click_on("Absent")
      expect(page).to have_content(absent_student.name)
      expect(page).not_to have_content(present_student.name)
    end
  end

  describe 'As a teacher' do
    before { login(teacher2) }

    let(:location) { create(:location) }
    let(:student3) { grove2.students.first }
    let(:student4) { grove2.students.last }
    let(:event) { student3.events.first }
    let(:event2) { student4.events.first }
    let(:scan) { event.scans.first }
    let(:scan2) { event2.scans.last }


    it 'shows all lost students who scanned into the wrong location' do
      event.update(student: student3, location: location)
      scan2.update(correct: true)
      dashboard_page.click_on("Grove Monitor")
      click_on("Lost")
      expect(page).to have_content(student3.name)
      expect(page).not_to have_content(student4.name)
    end

    it 'shows all lost students who have not scanned in anywhere' do
      event2.update(student: student4, location: location)
      dashboard_page.click_on("Grove Monitor")
      click_on("Lost")
      expect(page).to have_content(student3.name)
      expect(page).to have_content(student4.name)
    end
  end

  describe 'As a teacher' do
    let(:grove3) { create(:grove_with_scanned_in_students) }
    let(:teacher3) { grove3.teachers.first }
    let(:location3) { grove3.locations.first }
    let(:student5) { grove3.students.first }
    let(:student6) { grove3.students.last }


    before { login(teacher3) }


    it 'returns students by location' do
      dashboard_page.click_on("Grove Monitor")
      click_on(location3.name)

      expect(page).to have_content(student5.name)
      expect(page).to have_content(student6.name)
    end
  end
end





# PlaylistItem => Name, Location, Duration, timestamps, type
# ScheduledActivity => polymorphic on playlistitem
# FlexTimeActivity => polymorphic on playlistitem
# HomeStationActivity => polymorphic on playlistitem
# Activity => User(Id), FlextimeItem(Id), timestamps, CheckInTime, PlaylistItem(Id), PlaylistItem(Type)
# give me the activities for a student within the last hour
# Activity.playground #=> give me all the activities from the last hour where the last of those activities is a playground type
# School master_calendar => [900, 945, 1015]

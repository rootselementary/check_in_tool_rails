require 'rails_helper'
include Pages::Authentication

RSpec.feature 'Grove Monitor' do
  let(:grove)    { create(:grove_with_resources) }
  let(:teacher)  { grove.teachers.first }
  let(:grove2)   { create(:grove_with_absent_students) }
  let(:teacher2) { grove2.teachers.first }

  let(:dashboard_page) { Pages::DashboardPage.new }
  let(:grove_monitor_page) { Pages::GroveMonitorPage.new }

  describe 'as a teacher' do
    before do
      login(teacher)
      Scan.delete_all
      Event.delete_all
    end

    let(:student1) { grove.students.first }
    let(:student2) { grove.students.last }
    let(:location) { grove.locations.first }
    let(:location2) { grove.locations.last }

    it 'can be reached from the main dashboard' do
      dashboard_page.click_on("Grove Monitor")
      expect(current_path).to eq(admin_grove_monitor_all_path)
    end

    it 'shows all locations' do
      grove_monitor_page.visit_page
      expect(current_path).to eq(admin_grove_monitor_all_path)
      expect(grove_monitor_page).to have_content(location.name)
      expect(grove_monitor_page).to have_content(location2.name)
    end


    it 'shows all absent students' do
      student1.update(at_school: false)
      absent_student = student1
      present_student = student2
      grove_monitor_page.visit_page.click_on("Absent")
      expect(grove_monitor_page).to have_content(absent_student.name)
      expect(grove_monitor_page).not_to have_content(present_student.name)
    end

    it 'can mark student absent from lost page' do
      grove_monitor_page.visit_page.click_on("Lost")
      expect {
        within first('.student') do
          click_on("Mark as Absent")
        end
      }.to change {
        Student.where(at_school: true).count
      }.by -1
    end

    it 'can mark student present from absent page' do
      student1.update(at_school: false)
      grove_monitor_page.visit_page.click_on("Absent")
      expect {
        click_on("Mark as Present")
      }.to change {
        Student.where(at_school: true).count
      }.by 1
    end

    it 'shows all students that are supposed to be at a given location' do
      student1.events.create(location: location, start_time: Time.now-100, end_time: Time.now+3600)
      grove_monitor_page.visit_page.click_on(location.name)

      expect(grove_monitor_page).to have_content student1.name
    end

    it 'shows students that are scanned in' do
      student1.events.create(location: location, start_time: Time.now-100, end_time: Time.now+3600)
      Scan.create(location: location, timestamp: Time.now, correct:true, user_id: student1.id)
      grove_monitor_page.visit_page.click_on(location.name)

      expect(grove_monitor_page).to have_css('.scanned-in')
    end
  end
end

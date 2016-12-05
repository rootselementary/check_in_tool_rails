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
      expect(grove_monitor_page).to have_content(location.titleized_name)
      expect(grove_monitor_page).to have_content(location2.titleized_name)
    end


    it 'shows all absent students' do
      student1.update(at_school: false)
      absent_student = student1
      present_student = student2
      grove_monitor_page.visit_page.click_on("Absent")
      expect(grove_monitor_page).to have_content(absent_student.name)
      expect(grove_monitor_page).not_to have_content(present_student.name)
    end

    describe 'lost students' do
      before { visit_lost }
      let(:query) { -> { Student.where(at_school: true).count } }

      it 'shows both students' do
        expect(page).to have_text(student1.name)
        expect(page).to have_text(student2.name)
      end

      it 'orders them alphabetically' do
        expect(grove_monitor_page.students).to eq([student1.name, student2.name].sort)
      end

      it 'shows students that are currently not scanned in' do
        query = -> { page.has_text?(student1.name) }
        command = -> {
          student1.scans.create(scanned_in_at: Time.now, expires_at: 15.minutes.from_now)
          visit_lost
        }
        expect { command.call }.to change { query.call }.from(true).to(false)
      end

      it 'can mark student absent from lost page' do
        command = -> { within(first('.student')) { click_on("Mark as Absent") } }
        expect { command.call }.to change { query.call }.by(-1)
      end

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
      grove_monitor_page.visit_page.click_on(location.titleized_name)

      expect(grove_monitor_page).to have_content student1.name
    end

    it 'shows students that are scanned in at a location, but not supposed to be there' do
      student1.scans.create(location: location, expires_at: Time.now + 360, scanned_in_at: Time.now - 60, correct: false)
      grove_monitor_page.visit_page.click_on(location.titleized_name)

      expect(grove_monitor_page.unexpected_students).to eq([student1.name])
    end

    it 'shows students that are scanned in' do
      student1.events.create(location: location, start_time: Time.now-100, end_time: Time.now+3600)
      Scan.create(location: location, scanned_in_at: Time.now, correct:true, user_id: student1.id)
      grove_monitor_page.visit_page.click_on(location.titleized_name)

      expect(grove_monitor_page).to have_css('.scanned-in')
    end
  end
end

def visit_lost
  grove_monitor_page.visit_page.click_on("Lost")
end

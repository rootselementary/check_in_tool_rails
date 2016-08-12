class ScanCreator
  def self.create(student, scan_params)
    Scan.create!(student: student,
                 location_id: scan_params[:scanned_data],
                 timestamp: Time.now,
                 correct: scan_params[:location_id] == scan_params[:scanned_data],
                 activity_id: student.current_event.activity_id)
  end
end

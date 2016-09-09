class ScanCreator
  def self.new(student, scan_params)
    Scan.new(student: student,
            location_id: scan_params[:scanned_data],
            timestamp: Time.now,
            correct: scan_params[:location_id] == scan_params[:scanned_data],
            activity_id: student.current_event.activity_id)   
  end
end

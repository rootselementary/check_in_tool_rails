class ScanCreator
  def self.create(student, scan_params)
    @event = student.current_event
    Scan.create!(student: student,
                 location_id: scan_params[:scanned_data],
                 scanned_in_at: Time.now,
                 expires_at: @event.end_time,
                 correct: scan_params[:location_id] == scan_params[:scanned_data],
                 activity_id: @event.activity_id)
  end
end

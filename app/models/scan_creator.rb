class ScanCreator
  def self.create(student, scan_params)
    Scan.create!(student: student,
                location_id: scan_params[:location_id],
                timestamp: Time.now,
                correct: scan_params[:location_id] == scan_params[:scanned_data])
  end
end

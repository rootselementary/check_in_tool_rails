class ScanCreator
  def self.create(student, scan_params)
    scan = Scan.new(student: student,
            location_id: scan_params[:scanned_data],
            timestamp: Time.now,
            correct: scan_params[:location_id] == scan_params[:scanned_data],
            activity_id: student.current_event.activity_id)
    if scan.save
      broadcast(scan)
    end
  end 
  
  private 
    def self.broadcast(scan)
      ActionCable.server.broadcast 'monitor',
        scan: scan,
        student: scan.student,
    end 
end


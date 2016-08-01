require 'rails_helper'

RSpec.describe ChecksumHelper, type: :helper do
  it "will generate the same checksum for each unique schedule hash" do
    schedule =  {
       [[8,0],[8,30]] => {
         location: "Eating Area",
         activity: "Breakfast",
         creator: "Jill Tew"
       },
       [[8,30],[9,0]] => {
         location: "Classroom A",
         activity: "Spelling Lesson",
         creator: "JJ Leteach"
       },
       [[9,0],[10,0]] => {
         location: "Writing Center",
         acivity: "Writing exercises",
         creator: "JJ Leteach"
       }
       }
       checksum  = ChecksumHelper.get_checksum(schedule)
       checksum2 = ChecksumHelper.get_checksum(schedule)
       expect(checksum).to eq(checksum2)
  end

  it "will generate different checksums for different schedules" do
    schedule =  {
       [[8,0],[8,30]] => {
         location: "Eating Area",
         activity: "Breakfast",
         creator: "Jill Tew"
       },
       [[8,30],[9,0]] => {
         location: "Classroom A",
         activity: "Spelling Lesson",
         creator: "JJ Leteach"
       },
       [[9,0],[10,0]] => {
         location: "Writing Center",
         acivity: "Writing exercises",
         creator: "JJ Leteach"
       }}

    schedule2 =  {
      [[8,0],[8,30]] => {
        location: "Eating Area",
        activity: "Breakfast",
        creator: "Jill Tewer"
      },
      [[8,30],[9,0]] => {
        location: "Classroom A",
        activity: "Spelling Lesson",
        creator: "JJ Leteacher"
      },
      [[9,0],[10,0]] => {
        location: "Writing Center Extended",
        acivity: "Writing exercises",
        creator: "JJ Leteacher"
      }
      }
      checksum  = ChecksumHelper.get_checksum(schedule)
      checksum2 = ChecksumHelper.get_checksum(schedule2)
      expect(checksum).not_to eq(checksum2)
  end
end

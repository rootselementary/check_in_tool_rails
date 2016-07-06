['teacher', 'student', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

Teacher.create!(email: "teacher@example.com", password: "password")
Student.create!(email: "student@example.com", password: "password")

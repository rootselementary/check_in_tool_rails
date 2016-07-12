grove = Grove.create!(name: "Aspen")
Teacher.create!(name: "Jane Teacher", email: "teacher@example.com", password: "password", grove: grove)
Student.create!(name: "JJ Letest", email: "student@example.com", password: "password", grove: grove)

admin = Teacher.create!(name: "Daisy Admin", email: "admin@example.com", password: "password", grove: grove)
role = Role.create(name: 'admin')
admin.roles << role

grove = Grove.create!(name: "Aspen")
Teacher.create!(name: "Jane Teacher", email: "teacher@rootselementary.org", password: "password", grove: grove)
Student.create!(name: "JJ Letest", email: "jj.letest@rootselementary.org", password: "password", grove: grove)
Student.create!(name: "Jill Letest", email: "jill.letest@rootselementary.org", password: "password", grove: grove)

admin = Teacher.create!(name: "Daisy Admin", email: "admin@rootselementary.org", password: "password", grove: grove)
role = Role.create(name: 'admin')
admin.roles << role

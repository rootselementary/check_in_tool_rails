role = Role.create(name: 'admin')

grove = Grove.create!(name: "Aspen")
grove2 = Grove.create!(name: "Fir")
Grove.create!(name: "Pine")

Teacher.create!(name: "Jane Teacher",
                email: "jane@example.com",
                password: "password",
                grove: grove)
Teacher.create!(name: "Justin Teacher",
                email: "justin@example.com",
                password: "password",
                grove: grove2)
Student.create!(name: "Madison Student",
                email: "student@example.com",
                password: "password",
                grove: grove)
admin_role = Role.find_by(name: "admin")
admin = Teacher.create!(name: "Susie Admin",
                        email: "susie.admin@example.com",
                        password: "password",
                        grove: grove2)
admin.roles << admin_role

Student.create!(name: "JJ Letest",
                email: "jj.letest@rootselementary.org",
                password: "password",
                grove: grove2)

admin_role = Role.find_or_create_by(name: "admin")

grove = Grove.create!(name: "Aspen")
Grove.create!(name: "Fir")
Grove.create!(name: "Pine")

Teacher.create!(name: "Jane Teacher",
                email: "jane@example.com",
                password: "password",
                grove: grove)
Student.create!(name: "Madison Student",
                email: "student@example.com",
                password: "password",
                grove: grove)
admin = Teacher.create!(name: "Susie Admin",
                        email: "susie.admin@example.com",
                        password: "password",
                        grove: grove)
admin.roles << admin_role

Student.create!(name: "JJ Letest",
                email: "jj.letest@rootselementary.org",
                password: "password",
                grove: grove)
admin = Teacher.create!(name: "Roots Admin",
                        email: "dev@rootselementary.org",
                        password: "password",
                        grove: grove)
admin.roles << admin_role

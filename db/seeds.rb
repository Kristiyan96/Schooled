puts "Creating admins"

admin = Admin.create(email: "admin@schooled.bg", password: "password", password_confirmation: "password")

puts "Creating schools"

smg = School.create(name: "SMG")
feg = School.create(name: "FEG")

puts "Creating subjects"

maths     = Subject.new(name: "Mathematics")
bulgarian = Subject.new(name: "Bulgarian")
french    = Subject.new(name: "French")

puts "Creating headmasters"

Headmaster.create(email: "headmaster@smg.bg", password: "password", password_confirmation: "password", school: smg)
Headmaster.create(email: "headmaster@feg.bg", password: "password", password_confirmation: "password", school: feg)

puts "Creating teachers"

t1 = Teacher.create(email: "teacher@smg.bg", password: "password", password_confirmation: "password")
t2 = Teacher.create(email: "teacher@feg.bg", password: "password", password_confirmation: "password")

puts "Creating groups"
gr1 = Group.create(name: 'a', school: smg)
gr2 = Group.create(name: 'b', school: smg)
gr3 = Group.create(name: 'a', school: feg)
gr4 = Group.create(name: 'b', school: feg)

puts "Creating students"

s1 = Student.create(school: smg, group: gr1, first_name: "Kristiyan", last_name: "Tsvetanov", birthday: Date.new(1996,2,28), email: "student1@smg.bg", password: "password", password_confirmation: "password")
s2 = Student.create(school: smg, group: gr1, first_name: "Nikola", last_name: "Jichev", birthday: Date.new(1996,6,13), email: "student2@smg.bg", password: "password", password_confirmation: "password")
s3 = Student.create(school: smg, group: gr2, first_name: "Alexandra", last_name: "Mitkova", birthday: Date.new(1996,3,9), email: "student3@smg.bg", password: "password", password_confirmation: "password")
s4 = Student.create(school: feg, group: gr3, first_name: "Ivan", last_name: "Geshev", birthday: Date.new(1996,4,12), email: "student1@feg.bg", password: "password", password_confirmation: "password")
s5 = Student.create(school: feg, group: gr4, first_name: "Boyan", last_name: "Yotov", birthday: Date.new(1996,7,15), email: "student2@feg.bg", password: "password", password_confirmation: "password")
s6 = Student.create(school: feg, group: gr4, first_name: "Velin", last_name: "Vergiev", birthday: Date.new(1996,8,21), email: "student3@feg.bg", password: "password", password_confirmation: "password")

puts "Creating parents"

p1 = Parent.create(email: "dad@parent.bg", password: "password", password_confirmation: "password")
p2 = Parent.create(email: "mom@parent.bg", password: "password", password_confirmation: "password")
p3 = Parent.create(email: "momfat@parent.bg", password: "password", password_confirmation: "password")

puts "Linking parents and students"

# Mom hasn't authenticated for second child
Guardianship.create(parent: p1, child: s1)
Guardianship.create(parent: p1, child: s2)
Guardianship.create(parent: p1, child: s1)
Guardianship.create(parent: p2, child: s2)
Guardianship.create(parent: p2, child: s3)
Guardianship.create(parent: p2, child: s4)
Guardianship.create(parent: p3, child: s5)
Guardianship.create(parent: p3, child: s6)

puts "Creating school years"

y1 = SchoolYear.create(year: "2018", school: smg)
y2 = SchoolYear.create(year: "2017", school: feg)

puts "Creating courses"

c1 = Course.create(school: smg, group: gr1, subject: maths, school_year: y1, teacher: t1)
c2 = Course.create(school: smg, group: gr1, subject: bulgarian, school_year: y1, teacher: t1)
c3 = Course.create(school: smg, group: gr2, subject: french, school_year: y1, teacher: t1)
c4 = Course.create(school: smg, group: gr2, subject: maths, school_year: y1, teacher: t1)
c5 = Course.create(school: feg, group: gr3, subject: maths, school_year: y2, teacher: t2)
c6 = Course.create(school: feg, group: gr3, subject: french, school_year: y2, teacher: t2)
c7 = Course.create(school: feg, group: gr4, subject: bulgarian, school_year: y2, teacher: t2)
c8 = Course.create(school: feg, group: gr4, subject: maths, school_year: y2, teacher: t2)

puts "Creating marks"

Mark.create(student: s1, course: c1, grade: 5.0)
Mark.create(student: s1, course: c1, grade: 6.0)
Mark.create(student: s2, course: c2, grade: 4.0)
Mark.create(student: s2, course: c2, grade: 6.0)

puts "Creating remarks"

Remark.create(student: s1, course: c1, message: "Ставаш")
Remark.create(student: s2, course: c2, message: "Не-Ставаш")

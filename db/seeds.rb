puts "Creating admins"

admin = Admin.create(email: "admin@schooled.bg", password: "password", password_confirmation: "password")

puts "Creating schools"

smg = School.create(name: "SMG")
feg = School.create(name: "FEG")

puts "Creating subjects"

maths = Subject.new(school: smg, name: "Mathematics")
b1 = Subject.new(school: smg, name: "Bulgarian")

french = Subject.new(school: feg, name: "French")
b2 = Subject.new(school: feg, name: "Bulgarian")

puts "Creating headmasters"

Headmaster.create(email: "headmaster@smg.bg", password: "password", password_confirmation: "password", school: smg)
Headmaster.create(email: "headmaster@feg.bg", password: "password", password_confirmation: "password", school: feg)

puts "Creating teachers"

t1 = Teacher.create(email: "teacher@smg.bg", password: "password", password_confirmation: "password")
t2 = Teacher.create(email: "teacher@feg.bg", password: "password", password_confirmation: "password")

puts "Creating students"

s1 = Student.create(email: "student@smg.bg", password: "password", password_confirmation: "password_confirmation", school: smg)
s2 = Student.create(email: "student@feg.bg", password: "password", password_confirmation: "password_confirmation", school: feg)

puts "Creating parents"

p1 = Parent.create(email: "dad@parent.bg", password: "password", password_confirmation: "password")
p2 = Parent.create(email: "mom@parent.bg", password: "password", password_confirmation: "password")

puts "Linking parents and students"

# Mom hasn't authenticated for second child
Guardianship.create(parent: p1, child: s1)
Guardianship.create(parent: p1, child: s2)
Guardianship.create(parent: p2, child: s1)

puts "Creating classrooms"

Classroom.create(students: [s1], teacher: t1)
Classroom.create(students: [s2], teacher: t2)

puts "Creating school years"

y1 = SchoolYear.create(year: "2018", school: smg)
y2 = SchoolYear.create(year: "2017", school: feg)

puts "Creating marks"

Mark.new(student: s1, number: 6, subject: maths, school_year: y1)
Mark.new(student: s1, number: 5, subject: b1, school_year: y1)
Mark.new(student: s2, number: 6, subject: french, school_year: y2)
Mark.new(student: s2, number: 5, subject: b1, school_year: y2)

puts "Creating remarks"

Remark.new(student: s1, text: "Ставаш")
Remark.new(student: s2, text: "Не-Ставаш")

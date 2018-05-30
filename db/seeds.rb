puts "Creating schools"

smg = School.create(name: "Софийска Математическа Гимназия", email: 'smg@gmail.com', contact_number: "0885955926", address: "Sofia, bul. Levski 26", number: 128)
feg = School.create(name: "Френска Езикова Гимназия", email: 'fed@gmail.com', contact_number: "0885955925", address: "Varna, bul. Lomsko shose 12", number: 9)

puts "Creating subjects"

maths     = Subject.new(name: "Математика")
bulgarian = Subject.new(name: "Български")
french    = Subject.new(name: "Френски")

puts "Creating headmasters"

h1 = User.create(first_name: 'Ивайло', last_name: 'Цеков', email: "headmaster@smg.bg", password: "password", password_confirmation: "password")
h2 = User.create(first_name: 'Иван', last_name: 'Петров', email: "headmaster@feg.bg", password: "password", password_confirmation: "password")

puts "Creating teachers"

t1 = User.create(first_name: "Таня", last_name: "Баладжанова", email: "teacher1@smg.bg", password: "password", password_confirmation: "password")
t2 = User.create(first_name: "Мария", last_name: "Ценова", email: "teacher2@smg.bg", password: "password", password_confirmation: "password")
t3 = User.create(first_name: "Ваня", last_name: "Костадинова", email: "teacher3@smg.bg", password: "password", password_confirmation: "password")
t4 = User.create(first_name: "Анатолии", last_name: "Стоянов", email: "teacher4@feg.bg", password: "password", password_confirmation: "password")
t5 = User.create(first_name: "Благой", last_name: "Георгиев", email: "teacher5@feg.bg", password: "password", password_confirmation: "password")
t6 = User.create(first_name: "Сам", last_name: "Маринов", email: "teacher6@feg.bg", password: "password", password_confirmation: "password")

puts "Creating groups"
gr1 = Group.create(name: 'а', school: smg, teacher: t1, grade: 8)
gr1 = Group.create(name: 'б', school: smg, teacher: t2, grade: 8)
gr1 = Group.create(name: 'в', school: smg, teacher: t3, grade: 8)
gr2 = Group.create(name: 'а', school: feg, teacher: t4, grade: 9)
gr2 = Group.create(name: 'б', school: feg, teacher: t5, grade: 9)
gr2 = Group.create(name: 'в', school: feg, teacher: t6, grade: 9)

puts "Creating students"

s1 = User.create(group: gr1, number_in_class: 1, first_name: "Kristiyan", last_name: "Tsvetanov", birthday: Date.new(1996,2,28), email: "student1@smg.bg", password: "password", password_confirmation: "password")
s2 = User.create(group: gr1, number_in_class: 2, first_name: "Nikola", last_name: "Jichev", birthday: Date.new(1996,6,13), email: "student2@smg.bg", password: "password", password_confirmation: "password")
s3 = User.create(group: gr1, number_in_class: 3, first_name: "Alexandra", last_name: "Mitkova", birthday: Date.new(1996,3,9), email: "student3@smg.bg", password: "password", password_confirmation: "password")
s4 = User.create(group: gr2, number_in_class: 4, first_name: "Ivan", last_name: "Geshev", birthday: Date.new(1996,4,12), email: "student1@feg.bg", password: "password", password_confirmation: "password")
s5 = User.create(group: gr2, number_in_class: 5, first_name: "Boyan", last_name: "Yotov", birthday: Date.new(1996,7,15), email: "student2@feg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr2, number_in_class: 6, first_name: "Velin", last_name: "Vergiev", birthday: Date.new(1996,8,21), email: "student3@feg.bg", password: "password", password_confirmation: "password")

puts "Creating parents"

p1 = User.create(first_name: 'Petar', last_name: 'Novakov', email: "dad@parent.bg", password: "password", password_confirmation: "password")
p2 = User.create(first_name: 'Mihail', last_name: 'Terziev', email: "mom@parent.bg", password: "password", password_confirmation: "password")
p3 = User.create(first_name: 'Gergana', last_name: 'Spasova', email: "momfat@parent.bg", password: "password", password_confirmation: "password")

puts "Creating roles"

r1 = Role.create(name: "Student")
r2 = Role.create(name: "Teacher")
r3 = Role.create(name: "Headmaster")
r4 = Role.create(name: "Admin")

puts "Creating assignments"

# Headmasters
Assignment.create(role: r3, school: smg, user: h1)
Assignment.create(role: r3, school: feg, user: h2)

# Teachers
Assignment.create(role: r2, school: smg, user: t1)
Assignment.create(role: r2, school: feg, user: t4)

# Students
Assignment.create(role: r1, school: smg, user: s1)
Assignment.create(role: r1, school: smg, user: s2)
Assignment.create(role: r1, school: smg, user: s3)
Assignment.create(role: r1, school: feg, user: s4)
Assignment.create(role: r1, school: feg, user: s5)
Assignment.create(role: r1, school: feg, user: s6)

puts "Linking parents and students"

Parentship.create(parent: p1, student: s1)
Parentship.create(parent: p1, student: s2)
Parentship.create(parent: p1, student: s1)
Parentship.create(parent: p2, student: s2)
Parentship.create(parent: p2, student: s3)
Parentship.create(parent: p2, student: s4)
Parentship.create(parent: p3, student: s5)
Parentship.create(parent: p3, student: s6)

puts "Creating school years"

y1 = SchoolYear.create(year: "2017", school: smg)
y2 = SchoolYear.create(year: "2017", school: feg)

puts "Creating courses"

c1 = Course.create(school: smg, group: gr1, subject: maths, school_year: y1, teacher: t1)
c2 = Course.create(school: smg, group: gr1, subject: bulgarian, school_year: y1, teacher: t2)
c3 = Course.create(school: smg, group: gr1, subject: french, school_year: y1, teacher: t3)
c5 = Course.create(school: feg, group: gr2, subject: maths, school_year: y2, teacher: t4)
c6 = Course.create(school: feg, group: gr2, subject: french, school_year: y2, teacher: t5)
c7 = Course.create(school: feg, group: gr2, subject: bulgarian, school_year: y2, teacher: t6)

puts "Creating marks"

Mark.create(student: s1, course: c1, grade: 5.0)
Mark.create(student: s1, course: c1, grade: 6.0)
Mark.create(student: s2, course: c2, grade: 4.0)
Mark.create(student: s2, course: c2, grade: 6.0)

puts "Creating remarks"

Remark.create(student: s1, course: c1, message: "Ставаш")
Remark.create(student: s2, course: c2, message: "Не-Ставаш")

puts "Creating absences"

Absence.create(student: s1, course: c1, value: (1/3r))
Absence.create(student: s1, course: c1, value: (1/1r))
Absence.create(student: s2, course: c2, value: (1/3r))
Absence.create(student: s2, course: c2, value: (1/1r))

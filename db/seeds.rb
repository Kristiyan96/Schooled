puts "Creating schools"

smg = School.create(name: "Софийска Математическа Гимназия", email: 'smg@gmail.com', contact_number: "0885955926", address: "Sofia, bul. Levski 26", number: 128)
feg = School.create(name: "Френска Езикова Гимназия", email: 'fed@gmail.com', contact_number: "0885955925", address: "Varna, bul. Lomsko shose 12", number: 9)

puts "Creating subjects"

maths     = Subject.new(name: "Математика")
bulgarian = Subject.new(name: "Български")
french    = Subject.new(name: "Френски")

puts "Creating headmasters"

h1 = User.create(first_name: 'Ивайло', last_name: 'Ушагелов', email: "headmaster@smg.bg", password: "password", password_confirmation: "password")
h2 = User.create(first_name: 'Иван', last_name: 'Петров', email: "headmaster@feg.bg", password: "password", password_confirmation: "password")

puts "Creating teachers"

t1 = User.create(first_name: "Таня", last_name: "Баладжанова", email: "teacher1@smg.bg", password: "password", password_confirmation: "password")
t2 = User.create(first_name: "Мария", last_name: "Ценова", email: "teacher2@smg.bg", password: "password", password_confirmation: "password")
t3 = User.create(first_name: "Ваня", last_name: "Костадинова", email: "teacher3@smg.bg", password: "password", password_confirmation: "password")

t4 = User.create(first_name: "Анатолии", last_name: "Стоянов", email: "teacher4@feg.bg", password: "password", password_confirmation: "password")
t5 = User.create(first_name: "Благой", last_name: "Георгиев", email: "teacher5@feg.bg", password: "password", password_confirmation: "password")
t6 = User.create(first_name: "Сам", last_name: "Маринов", email: "teacher6@feg.bg", password: "password", password_confirmation: "password")

puts "Creating groups"
gr1 = Group.create(name: 'а', school: smg, teacher: t1, grade: 6)
gr2 = Group.create(name: 'б', school: smg, teacher: t2, grade: 6)
gr3 = Group.create(name: 'в', school: smg, teacher: t3, grade: 6)
gr3 = Group.create(name: 'а', school: smg, teacher: t1, grade: 7)
gr3 = Group.create(name: 'б', school: smg, teacher: t2, grade: 7)
gr3 = Group.create(name: 'в', school: smg, teacher: t3, grade: 7)
gr3 = Group.create(name: 'а', school: smg, teacher: t1, grade: 8)
gr3 = Group.create(name: 'б', school: smg, teacher: t2, grade: 8)
gr3 = Group.create(name: 'в', school: smg, teacher: t3, grade: 8)

gr4 = Group.create(name: 'а', school: feg, teacher: t4, grade: 9)
gr5 = Group.create(name: 'б', school: feg, teacher: t5, grade: 9)
gr6 = Group.create(name: 'в', school: feg, teacher: t6, grade: 9)

puts "Creating students"

s1 = User.create(group: gr1, number_in_class: 1, first_name: "Кристиян", last_name: "Цветанов", birthday: Date.new(1996,2,28), email: "student1@smg.bg", password: "password", password_confirmation: "password")
s2 = User.create(group: gr1, number_in_class: 2, first_name: "Никола", last_name: "Жишев", birthday: Date.new(1996,6,13), email: "student2@smg.bg", password: "password", password_confirmation: "password")
s3 = User.create(group: gr1, number_in_class: 3, first_name: "Александра", last_name: "Миткова", birthday: Date.new(1996,3,9), email: "student3@smg.bg", password: "password", password_confirmation: "password")
s4 = User.create(group: gr1, number_in_class: 4, first_name: "Иван", last_name: "Гешев", birthday: Date.new(1996,4,12), email: "student4@smg.bg", password: "password", password_confirmation: "password")
s5 = User.create(group: gr1, number_in_class: 5, first_name: "Боян", last_name: "Йотов", birthday: Date.new(1996,7,15), email: "student5@smg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr1, number_in_class: 6, first_name: "Велин", last_name: "Вергиев", birthday: Date.new(1996,8,21), email: "student6@smg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr1, number_in_class: 7, first_name: "Кирил", last_name: "Атанасов", birthday: Date.new(1996,8,21), email: "student7@smg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr1, number_in_class: 8, first_name: "Марин", last_name: "Вергиев", birthday: Date.new(1996,8,21), email: "student8@smg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr1, number_in_class: 9, first_name: "Мария", last_name: "Пешева", birthday: Date.new(1996,8,21), email: "student9@smg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr1, number_in_class: 10, first_name: "Виктория", last_name: "Вергиева", birthday: Date.new(1996,8,21), email: "student10@smg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr2, number_in_class: 6, first_name: "Велин", last_name: "Вергиев", birthday: Date.new(1996,8,21), email: "student31@smg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr2, number_in_class: 6, first_name: "Велин", last_name: "Вергиев", birthday: Date.new(1996,8,21), email: "student32@smg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr2, number_in_class: 6, first_name: "Велин", last_name: "Вергиев", birthday: Date.new(1996,8,21), email: "student33@smg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr2, number_in_class: 6, first_name: "Велин", last_name: "Вергиев", birthday: Date.new(1996,8,21), email: "student34@smg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr2, number_in_class: 6, first_name: "Велин", last_name: "Вергиев", birthday: Date.new(1996,8,21), email: "student35@smg.bg", password: "password", password_confirmation: "password")
s6 = User.create(group: gr2, number_in_class: 6, first_name: "Велин", last_name: "Вергиев", birthday: Date.new(1996,8,21), email: "student36@smg.bg", password: "password", password_confirmation: "password")

puts "Creating parents"

p1 = User.create(first_name: 'Петър', last_name: 'Новаков', email: "dad@parent.bg", password: "password", password_confirmation: "password")
p2 = User.create(first_name: 'Михаил', last_name: 'Терзиев', email: "mom@parent.bg", password: "password", password_confirmation: "password")
p3 = User.create(first_name: 'Гергана', last_name: 'Спасова', email: "momfa@parent.bg", password: "password", password_confirmation: "password")

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
Assignment.create(role: r2, school: smg, user: t2)
Assignment.create(role: r2, school: smg, user: t3)
Assignment.create(role: r2, school: feg, user: t4)
Assignment.create(role: r2, school: feg, user: t5)
Assignment.create(role: r2, school: feg, user: t6)

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
Parentship.create(parent: p2, student: s2)
Parentship.create(parent: p2, student: s3)
Parentship.create(parent: p2, student: s4)
Parentship.create(parent: p3, student: s5)
Parentship.create(parent: p3, student: s6)

puts "Creating school years"

y1 = SchoolYear.create(year: "2017/2018", school: smg, active: true, start: DateTime.parse("15/09/2017 8:00"), end: DateTime.parse("30/06/2018 8:00"))
y2 = SchoolYear.create(year: "2017/2018", school: feg, active: true, start: DateTime.parse("15/09/2017 8:00"), end: DateTime.parse("30/06/2018 8:00"))

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

puts "Creating time slots"

date = Date.today.beginning_of_week
TimeSlot.create_week_daily(school_year: y1, date: date, params: {start: Time.now.strftime("%H:%M"), end: (Time.now+45.minutes).strftime("%H:%M"), title: 'Час 1', school_year_id: y1.id})
TimeSlot.create_week_daily(school_year: y1, date: date, params: {start: (Time.now + 55.minutes).strftime("%H:%M"), end: (Time.now+100.minutes).strftime("%H:%M"), title: 'Час 2', school_year_id: y1.id})
TimeSlot.create_week_daily(school_year: y1, date: date, params: {start: (Time.now + 110.minutes).strftime("%H:%M"), end: (Time.now+155.minutes).strftime("%H:%M"), title: 'Час 3', school_year_id: y1.id})
TimeSlot.create_week_daily(school_year: y1, date: date, params: {start: (Time.now + 165.minutes).strftime("%H:%M"), end: (Time.now+210.minutes).strftime("%H:%M"), title: 'Час 4', school_year_id: y1.id})
TimeSlot.create_week_daily(school_year: y1, date: date, params: {start: (Time.now + 220.minutes).strftime("%H:%M"), end: (Time.now+265.minutes).strftime("%H:%M"), title: 'Час 5', school_year_id: y1.id})
TimeSlot.create_week_daily(school_year: y1, date: date, params: {start: (Time.now + 275.minutes).strftime("%H:%M"), end: (Time.now+320.minutes).strftime("%H:%M"), title: 'Час 6', school_year_id: y1.id})
TimeSlot.create_week_daily(school_year: y1, date: date, params: {start: (Time.now + 330.minutes).strftime("%H:%M"), end: (Time.now+375.minutes).strftime("%H:%M"), title: 'Час 7', school_year_id: y1.id})
TimeSlot.create_week_daily(school_year: y1, date: date, params: {start: (Time.now + 385.minutes).strftime("%H:%M"), end: (Time.now+430.minutes).strftime("%H:%M"), title: 'Час 8', school_year_id: y1.id})

puts "Creating schedules"

slots_today = TimeSlot.for_school(smg).for_day(Date.today)
Schedule.create_with_type(school: smg, params: {course_id: c1.id, time_slot_id: slots_today[0].id, type: 'series_7'})
Schedule.create_with_type(school: smg, params: {course_id: c1.id, time_slot_id: slots_today[1].id, type: 'series_7'})
Schedule.create_with_type(school: smg, params: {course_id: c2.id, time_slot_id: slots_today[2].id, type: 'series_7'})
Schedule.create_with_type(school: smg, params: {course_id: c2.id, time_slot_id: slots_today[3].id, type: 'series_7'})
Schedule.create_with_type(school: smg, params: {course_id: c3.id, time_slot_id: slots_today[4].id, type: 'series_7'})
Schedule.create_with_type(school: smg, params: {course_id: c3.id, time_slot_id: slots_today[5].id, type: 'series_7'})

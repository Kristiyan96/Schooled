puts 'Generating seeds...'

school_id = School.find_or_create_by!(
  name: 'SMG',
  address: 'Sofia',
  phone_number: '0885955926'
).id

course_id = Course.find_or_create_by!(
  school_id: school_id,
  year: Date.current
).id
Subject.find_or_create_by!(
  name: 'Mathematics',
  grade: 10,
  course_id: course_id
)
group_id = Group.find_or_create_by!(
  grade: 10,
  name: 'a',
  school_id: school_id
).id

user_seeds = [
  { name: 'Kristiyan Tsvetanov',
    email: 'kris@example.com', password: 'password',
    admin: true },
  { name: 'Nikola Jichev',
    email: 'niko@example.com', password: 'password',
    admin: true },
  { name: 'Ivancho Petrov',
    email: 'ivancho@example.com', password: 'password',
    admin: false,
    school_id: school_id, role: 0, group_id: 1 },
  { name: 'Mariya Petrova', email: 'mariya@example.com', password: 'password' },
  { name: 'Antony Stoyanov',
    email: 'tonkata@example.com', password: 'password', admin: false,
    school_id: school_id, role: 3 },
  { name: 'Veliko Kolev',
    email: 'kolev@example.com', password: 'password', admin: false,
    school_id: school_id, role: 1 }
]

user_seeds.each do |params|
  User.find_or_create_by!(params.except(:password)) do |user|
    user.password = params[:password] || 'password'
  end
end
teacher_id = User.find_by(email: 'kolev@example.com').id

parent = User.find_by(name: 'Mariya Petrova')
ivancho = User.find_by(email: 'ivancho@example.com')
ivancho.update!(parent_id: parent.id)

StudentClass.find_or_create_by!(
  course_id: course_id,
  group_id: group_id,
  user_id: teacher_id
)

puts 'Done ...'

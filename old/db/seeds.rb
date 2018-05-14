puts "Generating seeds..."

School.find_or_create_by(
  {name: 'СМГ',
  address: 'София', 
  phone_number: '0885955926'
  }
)

users_seed = [
  {name: 'Кристиян Цветанов',
  email: 'kris@example.com', password: 'password',
  password_confirmation: 'password', admin: true, accepted: true},
  {name: 'Никола Жишев',
  email: 'niko@example.com', password: 'password',
  password_confirmation: 'password', admin: true, accepted: true},
  {name: 'Антони Стоянов',
  email: 'tonkata@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 2, accepted: true},
  {name: 'Велико Колев',
  email: 'kolev@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 1, accepted: true},
  {name: 'Лариса Андреева',
  email: 'larissa@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 1, accepted: true},
  {name: 'Таня Баладжанова',
  email: 'tanq@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 1, accepted: true},
  {name: 'Мишо Галев',
  email: 'misho@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 1, accepted: true},
  {name: 'Ася Цонева',
  email: 'coneva@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 1, accepted: true},
  {name: 'Владимир Паскалев',
  email: 'paskal@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 1, accepted: true},
  {name: 'Мария Бозаджийска',
  email: 'marcheto@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 1, accepted: true},
  {name: 'Симеон Дочев',
  email: 'simo@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 1, accepted: true},
  {name: 'Иван Драганов',
  email: 'ivancho@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 1, address: "София", accepted: true},
  {name: 'Александър Петров',
  email: 'alex@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 2, address: "София", accepted: true},
  {name: 'Ангел Димитров',
  email: 'acho@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 3, address: "София", accepted: true},
  {name: 'Димитър Петров',
  email: 'mitko@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 4, address: "София", accepted: true},
  {name: 'Ива Милушева',
  email: 'iva@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 5, address: "София", accepted: true},
  {name: 'Марта Благоева',
  email: 'marta@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 6, address: "София", accepted: true},
  {name: 'Блага Димитрова',
  email: 'blaga@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 7, address: "София", accepted: true},
  {name: 'Лариса Вергиева',
  email: 'lary@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 8, address: "София", accepted: true},
  {name: 'Петьо Даулджиев',
  email: 'pepi@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 9, address: "София", accepted: true},
  {name: 'Марин Горнишки',
  email: 'marin@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 10, address: "София", accepted: true},
  {name: 'катерина Маринова',
  email: 'katy@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 11, address: "София", accepted: true},
  {name: 'Михаил Божилов',
  email: 'mihail@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 12, address: "София", accepted: true},
  {name: 'Боряна Конова',
  email: 'buba@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 13, address: "София", accepted: true},
  {name: 'Кати Маринова',
  email: 'katty@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 14, address: "София", accepted: true},
  {name: 'Веселин Гешев',
  email: 'veselin@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 15, address: "София", accepted: true},
  {name: 'Любомир Рангачев',
  email: 'lubo96@example.com', password: 'password',
  password_confirmation: 'password', admin: false,
  school_id: 1, role: 0, group_id: 1, number: 16, address: "София", accepted: true}
]

users_seed.each do |user_params|
  User.create(user_params)
end

Subject.find_or_create_by(
  {
    name: 'Математика',
    abbreviation: 'Мат.',
    grade: 10
  }
)
Subject.find_or_create_by(
  {
    name: 'Информатика',
    abbreviation: 'ИТ',
    grade: 10
  }
)
Subject.find_or_create_by(
  {
    name: 'Биология',
    abbreviation: 'Биология',
    grade: 10
  }
)
Subject.find_or_create_by(
  {
    name: 'Физика',
    abbreviation: 'Физика',
    grade: 10
  }
)
Subject.find_or_create_by(
  {
    name: 'Химия',
    abbreviation: 'Химия',
    grade: 10
  }
)
Subject.find_or_create_by(
  {
    name: 'Български език и литература',
    abbreviation: 'БЕЛ',
    grade: 10
  }
)
Subject.find_or_create_by(
  {
    name: 'Физическо възпитание и спорт',
    abbreviation: 'ФВС',
    grade: 10
  }
)
Subject.find_or_create_by(
  {
    name: 'Философия',
    abbreviation: 'Философия',
    grade: 10
  }
)
Group.find_or_create_by(
  {
    grade: 10,
    name: 'a',
    school_id: 1,
    user_id: 10
  }
)
Course.find_or_create_by(
  {
    subject_id: 1,
    school_id: 1,
    year: 2017,
    grade: 10,
    group_id: 1,
    user_id: 4,
    study_hours: 120
  }
)
Course.find_or_create_by(
  {
    subject_id: 2,
    school_id: 1,
    year: 2017,
    grade: 10,
    group_id: 1,
    user_id: 5,
    study_hours: 50
  }
)
Course.find_or_create_by(
  {
    subject_id: 3,
    school_id: 1,
    year: 2017,
    grade: 10,
    group_id: 1,
    user_id: 6,
    study_hours: 100
  }
)
Course.find_or_create_by(
  {
    subject_id: 4,
    school_id: 1,
    year: 2017,
    grade: 10,
    group_id: 1,
    user_id: 7,
    study_hours: 120
  }
)
Course.find_or_create_by(
  {
    subject_id: 5,
    school_id: 1,
    year: 2017,
    grade: 10,
    group_id: 1,
    user_id: 8,
    study_hours: 50
  }
)
Course.find_or_create_by(
  {
    subject_id: 6,
    school_id: 1,
    year: 2017,
    grade: 10,
    group_id: 1,
    user_id: 9,
    study_hours: 100
  }
)
Course.find_or_create_by(
  {
    subject_id: 7,
    school_id: 1,
    year: 2017,
    grade: 10,
    group_id: 1,
    user_id: 10,
    study_hours: 120
  }
)
Course.find_or_create_by(
  {
    subject_id: 8,
    school_id: 1,
    year: 2017,
    grade: 10,
    group_id: 1,
    user_id: 11,
    study_hours: 50
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 26700,
    end_time: 29400
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 26700,
    end_time: 29400
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 30000,
    end_time: 32700
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 33900,
    end_time: 36600
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 37200,
    end_time: 39900
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 40500,
    end_time: 43200
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 43800,
    end_time: 46500
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 47100,
    end_time: 49800
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 51000,
    end_time: 53700
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 54300,
    end_time: 57000
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 57600,
    end_time: 60300
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 60900,
    end_time: 63600
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 63900,
    end_time: 66600
  }
)
Slot.find_or_create_by(
  {
    school_id: 1,
    start_time: 67200,
    end_time: 69900
  }
)

puts 'Done ...'

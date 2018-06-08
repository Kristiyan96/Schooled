class Absence < ApplicationRecord
  belongs_to :school_year
  belongs_to :schedule
  belongs_to :student, foreign_key: "student_id", class_name: "User"

  attribute :value, :rational
  enum kind: [:first_semester, :second_semester, :final]
  enum category: [:permanent, :excused]

  def self.create_multiple(args)
    students = args[:student_ids].reject(&:blank?)
    args = args.except(:student_ids)

    students.map! do |s|
      #TODO(KRIS): Pass in schedule id and remove second merge
      args.to_h.merge(student_id: s).merge(schedule_id: 1)
    end

    p students
    import(students)
  end
end

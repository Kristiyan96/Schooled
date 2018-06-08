class MessageSender
  attr_reader :message_type

  def initialize(sender, args)
    # Message type is an array of [:user, :group_students, :group_parents, :teachers, :all_students, :all_parents]
    @sender = sender
    @recepient = args[:user_id]
    @message_type = args[:message_type].map(&:to_sym)
    @group = args[:group_id]
    @school_id = args[:school_id]
    @text = args[:text]
  end

  def call
    messages = recepients.map { |r| { sender_id: @sender, recepient_id: r.id, text: @text } }

    # Trigger notification callback on socket here.
    Message.import(messages)
  end

  def recepients
    return @recepients if @recepients

    @recepients = User.none
    to_user!
    to_group_students!
    to_group_parents!
    to_teachers!
    to_all_students!
    to_all_parents!
    @recepients
  end

  private

  def to_user!
    @recepients = @recepients.or(User.where(id: @sender)) if :user.in? message_type
  end

  def to_group_students!
    @recepients = @recepients.or(User.where(group_id: @group)) if :group_students.in? message_type
  end

  def to_group_parents!
    if :group_parents.in? message_type
      @recepients = @recepients.or(User.where(students: User.where(group_id: @group)))
    end
  end

  def to_teachers!
    if :teachers.in? message_type
      @recepients = @recepients.or(school.teachers)
    end
  end

  def to_all_students!
    if :all_students.in? message_type
      @recepients = @recepients.or(school.students)
    end
  end

  def to_all_parents!
    if :all_parents.in? message_type
      @recepients = @recepients.or(User.where(students: school.students))
    end
  end

  def school
    @school ||= School.find(@school_id)
  end
end

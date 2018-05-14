# Accept student to a group
class InvitationAccepter
  attr_reader :student, :invitation

  def initialize(invitation)
    @invitation = invitation
    @student = invitation.student
  end

  def save!
    student = invitation.student
    student.accepted = true
    student.group_id = invitation.group_id
    student.address = invitation.address
    student.number = invitation.phone_number
    student.identification = invitation.identification
    student.save!
  end
end

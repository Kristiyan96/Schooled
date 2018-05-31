module GroupsHelper
  def group_name(group)
    "#{group.try(:grade)}#{group.try(:name)}"
  end
end

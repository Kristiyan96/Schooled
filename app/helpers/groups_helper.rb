# frozen_string_literal: true

module GroupsHelper
  def group_name(group)
    "#{group.try(:grade)}#{group.try(:name)}".upcase
  end
end

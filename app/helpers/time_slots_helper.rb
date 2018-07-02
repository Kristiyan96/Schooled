# frozen_string_literal: true

module TimeSlotsHelper
  def slot_period(slot)
    "#{slot.start.strftime('%H:%M')} - #{slot.end.strftime('%H:%M')}" if slot
  end
end

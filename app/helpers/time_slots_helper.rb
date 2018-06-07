module TimeSlotsHelper
  def slot_period(slot)
    "#{slot.start.strftime('%H:%M')} - #{slot.end.strftime('%H:%M')}"
  end
end

$("#day-schedule").html("<%= j ( render partial: 'time_slots/slot', collection: @time_slots, as: :slot %>");

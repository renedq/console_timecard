module EventHelper
  def regular_sign_up_available?
    @event.full? == false && @event.rsvp_passed? == false && already_attending? == false
  end

  def waitlist_sign_up_available?
    (already_on_waitlist? == false && already_attending? == false) && (@event.full? || @event.rsvp_passed?)
  end

  def already_attending?
    EventAttendee.exists?(event: @event, attendee: @current_user)
  end

  def already_on_waitlist?
    WaitlistAttendee.exists?(waitlist: @event.waitlist, prospective_attendee: @current_user)
  end

  def removable_from_sign_up?
    EventAttendee.exists?(event: @event, attendee: @current_user)
  end

  def removable_from_waitlist?
    WaitlistAttendee.exists?(waitlist: @event.waitlist, prospective_attendee: @current_user)
  end

  def not_on_attendee_list?
    !removable_from_sign_up?
  end

  def not_on_waitlist?
    !removable_from_waitlist?
  end
end

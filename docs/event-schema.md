
# Event with id = x
  ID (universally unique)                                               id (uuid)
  Name of event (use as title of page)                                  name (xhtml?)
  Short name (use as label on links)                                    link_label (text)
  Brief description (for tooltip pop-ups, pull quotes, cards, etc.)     link_description (xhtml)
  Page slug (name-of-event for the URL)                                 slug (text train-case)
  Full URL for the event page                                           full_path (text URL path)

  Full description                                                      description (xhtml)
  Attendee limit                                                        max_attendees (integer)
  Open to pubic?                                                        access (enum: PUBLIC | PRIVATE | MIXED)
  Free?                                                                 free (enum: FREE | PAID | MIXED)
  Ticketing link                                                        ticket_url (URL or text URL path)?

  Duration(s) - one or more Duration objects assoicated with event
    ID
    Start date/time                                                     begins_at (timestamp)
    End date/time                                                       ends_at (timestamp)
    Recurrence                                                          rrule (RRULE)
    Notes - anything relevant to this duration                          notes (xhtml)

  Venue(s) - one or more Venue objects associated with event
    # Venue-event combinations can have associated durations
    ID
    Name of location                                                      name (xhtml?)
    Short name (use as label on links)                                    link_label (text)
    Brief description (for tooltip pop-ups, pull quotes, cards, etc.)     link_description (xhtml)
    Page slug (name-of-event for the URL)                                 slug (text train-case)
    Full URL for the event page                                           full_path (text URL path)
    Geographic location                                                   latlong
    Seating chart                                                         

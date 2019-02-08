# Schema work

## Duration

A period of time with start and stop DateTimes and a repetition algorithm (new durations calculated)?

## Event

* Any event that has one or more durations:
  * The full event over one or more days, e.g., a conference
  * A single day within that event that has a schedule
  * A single activity within that day that fits in the schedule and has an agenda
  * An agenda item with a start/stop time
* Nestable

## Account

* A person involved in an event in some manner
* Can have login privileges or not
* Login privileges makes the person a RegisteredUser, who has one or more roles:
  * God
    * All admin privileges plus
    * Reset database
    * Add new capabilities
    * Ban anyone anytime for any duration
  * Admin
    * All staff privileges plus:
    * CRUD staff
    * All channel notifications
    * View all feedback (staff included)
    * Ban staff, presenters, panelists, reps, recruiters, attendees
      * Can delegate any of above temporarily
  * Staff
    * All attendee privileges plus:
    * Review of presenter, panelist, rep, recruiter, media, and attendee activity (with veto)
    * View event statistics
    * CRUD events
    * View event feedback
    * Chat with others, answer questions, respond to feedback
    * View/edit speaker/panelist/rep/recruiter info
    * Briefly ban presenters, panelists, reps, recruiters, attendees
      * Automatic notification of admin
      * Admin must agree or ban reverts
  * Presenter
    * All attendee privileges plus:
    * Post bio
    * Post slides
    * Post video
    * Post links to related resources
    * Receive and respond to questions
    * Chat (ask me anything)
  * Panelist
    * All attendee privileges plus:
    * Post bio
    * Receive and respond to questions
    * Chat (ask me anything)
  * Rep (business)
    * All attendee privileges plus:
    * Post information
    * Post job listings
    * Receive CVs
    * Link to demos
    * Link to website
  * Recruiter
    * All attendee privileges plus:
    * Post information
    * Post job listings
    * Receive CVs
    * Link to website
  * Media
    * All attendee privileges plus:
    * View media kit
    * Download news releases
    * Request interview
  * Attendee
    * View more detailed event info
    * Add event to my calendar
    * Remove event from my calendar
    * View conflicts/overlaps
    * View free time
    * View "directions" to from one event to another (with estimated travel time)
    * View links to related resources
    * Get notifications/reminders/updates
    * Manage personal profile
      * About me
    * Manage preferences
      * Notifications
      * Location pref?
    * View venue map
      * Seating plans
      * Seats available (count or by seat if assigned)
      * Best routes
      * Facilities nearby and travel times (walking, driving, transit, bike)
        * Toilets and type
        * Water
        * Food & drink
        * Phone
        * Medical
        * Coffee
        * Alcohol
        * Nightlife
      * Find food/coffee (suggestions based on input criteria)
      * Find my friend (if friend allows)
      * Where am I? (Location)
    * Ask question (chat with staff)
    * Ask question for FAQ
    * Provide feedback
    * Report bugs
    * Post CV
      * Send to recruiter/rep




* Users who do not have a login are GuestUsers. (Not in db.)
  * View event information
    * Attendence limits/tickets sold/interest noted
  * View schedules/agendas
  * Search/sort schedule
  * View presenter/panelist bio
  * View list of sponsors/supporters
  * View organization information
  * Purchase tickets
  * Purchase swag


# Actions

## CRUD

* Create singly or in batches
* Update singly or in batches / Upsert
* Retrieve singly or in batches (filter, paginate)
* Delete singly or in batches

## SignIn

* Update password
* Update profile
* Update email address


## Purchase

* Tickets
* Swag

pocketstackoverflow
===================

MobileDevCodeChallenge

Utilizes api.stackexchange.com API for site stackoverflow

Makes use of page 1 of /questions/ and /badges/ to display a list of recent
questions from the site.  Once chosen, it will display further information about
the user.  If information needs to be pulled again, it will do so on an individual
basis and update the UI after a one second delay.  Due to the requirements for this
version and the lack of a timestamp on when badges are earned, 2 JSON requests must
be utilized to get more six month old badges and the most recent badge.

Main class that does the data transport allows complete multi-page download via /has_more/
as long as needsAllPages is TRUE.  However /backoff/ was NOT implemented with this version

A rough cache implementation was included to lower the amount of api calls during
debugging and is technically incomplete.


# Oauth Test

This app was built when we started working on adding oauth2 support to
StatusGator.

# Setup

Assuming SG runs locally at `http://localhost:3000`

* As an admin go to `/oauth/applications` in StatusGator.  
* Create yourself an application.
* Assign the Application UID to `STATUSGATOR_OAUTH_ID` in `.env.local`
* Assign the Secret to `STATUSGATOR_OAUTH_SECRET` in `.env.local`
* Run `rackup`
* Visit `http://localhost:9292`

If you've never run this before, and all goes as planned, you'll go through
the oauth2 process, and be redirected back to this app.  At that point you'll
see the response of the StatusGator `/api/v1/ping` call.

Unless you ran into problems.


Good luck.


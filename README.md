# StatusGator Oauth Test

This app is a simple demonstration of the StatusGator Oauth2 API.

# Setup

Assuming StatusGator is running at `https://statusgator.com`:

* Run `bundle`
* A StatusGator admin will need to create an applicaiton for you under
  `/oauth/applications` in StatusGator.
* Once created, you will be supplied with OAuth ID and Secret.
* Set 'http://localhost:9292/oauth/callback' as a Redirect URI
* Assign the Application UID to `STATUSGATOR_OAUTH_ID` in `.env.local`
* Assign the Secret to `STATUSGATOR_OAUTH_SECRET` in `.env.local`
* Run `rackup`
* Visit `http://localhost:9292`

If you've never run this before, and all goes as planned, you'll go through the
oauth2 process, and be redirected back to this app.  At that point you'll see
the response of the StatusGator `/api/v1/ping` call.

If you run into problems, you can contact hi@statusgator.com.

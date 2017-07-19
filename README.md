# SMS Notify

A (very) simple Ruby application to send SMS using Twilio API.

## Prerequisites

First of all you need to create a [Twilio Account](https://www.twilio.com). We
will be using the service
[Programmable SMS](https://www.twilio.com/console/sms/dashboard). To get started
with that you need to add a phone number capable to send SMS to your
destination.

After doing that, write down your API
[LIVE credentials and TEST
credentials](https://www.twilio.com/console/account/settings).

## Set up the application

### Clone this repository

```
git clone https://github.com/leoditommaso/sms_notify.git
cd sms_notify
```

### Install the required Gems

```
bundle install
```

### Configure the application

Copy the config/config.yml.example file with the name config/config.yml and
replace the appropiate values:

```yaml
production:
  twilio:
    account_sid: 'YOUR_ACCOUNT_SID'
    auth_token: 'YOUR_AUTH_TOKEN'
    from: 'YOUR_FROM_NUMBER'
    body: 'MESSAGE_BODY'
  destination_numbers_file: 'data/numbers'
testing:
  twilio:
    account_sid: 'YOUR_TESTING_ACCOUNT_SID'
    auth_token: 'YOUR_TESTING_AUTH_TOKEN'
    from: "+15005550006"
    body: "Test message."
  destination_numbers_file: 'data/testing'
```

Note that there are two environments for this application, production and
testing. For the testing environment you just need to replace account_sid and
auth_token with the ones assigned for your Twilio account. For the production
environment you also need to define the from number (the one assigned to your
account) and the message body.

The destination_numbers_file configuration option specifies where will the
application look for the file with destination mobile numbers. By default is
data/testing for testing environment and data/numbers for production.

**Note:** body message can be up to 160 characters long if using standard ASCII.
If your message includes any non-ASCII character, Twilio will automatically
change encoding to Unicode and reduce the number of characters per message to
80. Have in mind that you will be charged for each message you send.

### Destination numbers file

This file defines the numbers to send SMS to. It expects one phone number per
line and each of them with the
[E.164 number
formatting](https://support.twilio.com/hc/en-us/articles/223183008-Formatting-International-Phone-Numbers).
Check data/testing file for an example.

## Usage

Just run:

```
ruby app.rb
```

If you do not specify which environment to use, it defaults to testing. So,
after running the application check the log file at log/testing.log and there
you will find the result of the execution. In this case, many errors and one
successful delivery, based on the numbers defined in data/testing and the
[mapping provided by
Twilio](https://www.twilio.com/docs/api/rest/test-credentials).

To run in the production environment you need to define an environment variable
called APP_ENV with production as its value. So, execution becomes:

```
APP_ENV=production ruby.app
```

## License

The MIT License (MIT)

Copyright (c) 2017 Leandro Di Tommaso

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Authors

* Author:: Leandro Di Tommaso (<leandro.ditommaso@mikroways.net>)


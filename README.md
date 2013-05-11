# Cleanweb

[![Build Status](https://travis-ci.org/arrowcircle/cleanweb.png?branch=master)](https://travis-ci.org/arrowcircle/cleanweb)
[![Code Climate](https://codeclimate.com/github/arrowcircle/cleanweb.png)](https://codeclimate.com/github/arrowcircle/cleanweb)

Cleanweb is Ruby gem Yandex Cleanweb service.

## Installation

Add this line to your application's Gemfile:

    gem 'cleanweb'

Get key here:

    http://api.yandex.ru/key/form.xml?service=cw

Set key to Cleanweb class:

    Cleanweb.api_key = "YOUR KEY HERE"

## Usage

To check if content spam or not, create a cleanweb instance and check it for spam:

    cw = Cleanweb.new({:subject = > "My Test Subject", :body => "My Test Body"})
    cw.spam?
    => false

You can add more info to initial params. Here is the list:

* `ip` - user IP address,
* `email` - user email,
* `name` - user footer signature,
* `login` - user login,
* `realname` - user real name

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

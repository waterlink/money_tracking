# MoneyTracking

[![Join the chat at https://gitter.im/waterlink/money_tracking](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/waterlink/money_tracking?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

CLI tool for tracking your expenses.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'money_tracking'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install money_tracking

## Usage

```
$ money expenses list
Empty.

$ money expenses create 37.9 euro food
Created new expense with id 7dt0ibnv.

$ money expenses create 25 euro internet landline
Created new expense with id 2pa44pry.

$ money expenses list
2pa44pry - 2015-04-17 18:17:37: 25.00 euro [internet landline]
7dt0ibnv - 2015-04-17 18:24:21: 37.90 euro [food]

$ money expenses update 7dt0ibnv --amount 37.95
Updated expense 7dt0ibnv.

$ money expenses list
2pa44pry - 2015-04-17 18:17:37: 25.00 euro [internet landline]
7dt0ibnv - 2015-04-17 18:24:21: 37.95 euro [food]

$ money expenses delete 2pa44pry
Deleted expense 2pa44pry.

$ money expenses list
7dt0ibnv - 2015-04-17 18:24:21: 37.95 euro [food]
```

## Contributing

1. Fork it ( https://github.com/waterlink/money_tracking/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [waterlink](https://github.com/waterlink) Oleksii Fedorov - creator, maintainer

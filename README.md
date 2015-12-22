[![Circle CI](https://circleci.com/gh/Originate/weighted_score.svg?style=svg)](https://circleci.com/gh/Originate/weighted_score)
[![Coverage Status](https://coveralls.io/repos/Originate/weighted_score/badge.svg?branch=master&service=github)](https://coveralls.io/github/Originate/weighted_score?branch=master)
[![Code Climate](https://codeclimate.com/github/Originate/weighted_score/badges/gpa.svg)](https://codeclimate.com/github/Originate/weighted_score)

# WeightedScore

Weighted Score provides a light weight framework for creating weighted
scoring systems. It allows you to calculate weighted scores using score
calculator classes for each of the weighted components.

## Installation

Add this line to your application's Gemfile:

    gem 'weighted_score'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install weighted_score

## Usage

Start by creating one or more score calculating classes.
You can optionally subclass `WeightedScore::Score`.
If you do not subclass the provided `Score` class then
you your initializer should accept one argument which represents
the scorable item and you must implement a `calculate` method.

**Either way the `calculate` method must return a numeric value.**

```ruby
require 'weighted_score'

class CriteriaOne < WeightedScore::Score
  def calculate
    return 1 if scorable >= 10
    0
  end
end

class CriteriaTwo < WeightedScore::Score
  def calculate
    return 1 if scorable.even?
    0
  end
end

class CriteriaThree < WeightedScore::Score
  def calculate
    return 1 if scorable % 4 == 0
    0
  end
end
```

Then create a weighted score calculator class:

```ruby
require 'weighted_score'

class Calculator < WeightedScore::WeightedScore
  score CriteriaOne => 0.5
  score CriteriaTwo => 0.25
  score CriteriaThree => 0.25
end
```

Finally, you can then use it like this:

```ruby
Calculator.new(5).calculate      #=> 0
Calculator.new(2).calculate      #=> 0.25
Calculator.new(4).calculate      #=> 0.5
Calculator.new(12).calculate     #=> 1
Calculator.new(13).calculate     #=> 0.5
Calculator.new(14).calculate     #=> 0.75
```

## An Example Customer Valuation Calculator

```ruby
require 'weighted_score'

class EmailScore < WeightedScore::Score
  def calculate
    return 1 if scorable.email.present?
    0
  end
end

class NewsletterScore < WeightedScore::Score
  def calculate
    return 1 if scorable.newsletter_status == 'subscribed'
    0
  end
end

class OrdersScore < WeightedScore::Score
  def calculate
    scorable.orders.size - scorable.returns.size
  end
end

class CustomerValuation < WeightedScore::WeightedScore
  score EmailScore => 5
  score NewsletterScore => 10
  score OrdersScore => 1
end

CustomerValuation.new(user).calculate
```


## Contributing

1. Fork it ( https://github.com/Originate/weighted_score/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

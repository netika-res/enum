# Enum

This is a very basic implementation of enums in Ruby. Forked from [mezuka/enum](https://github.com/mezuka/enum). The cornerstone of the mezuka library is **safety**. This implementation uses hashes instead of strings to create enums. It is a work in progress and evolves depending on developers needs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'safe-hash-enum'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install safe-hash-enum

## Usage

Define set of enums with code like this:
```ruby
class Side < Enum::Base
  values({left: 'left', right: 'right'})
end
```

Now get a safely defined value with the `enum` method with its `Symbol` or `String` type as argument. If there is no defined such value `Enum::TokenNotFoundError` exception will be raised. And this is the **safety** - you will be noticed about the problem and fix it by introducing a new value or fixing a source of the invalid value. While others implementations of enums in Ruby (that I know) just silently ignore invalid values returning `nil` this one will raise the exception **always**. Example of usage:

```ruby
Side.enum(:left) # => {:left => "left"}
Side.enum('left') # => {:left => "left"}
Side.enum(:invalid) # => Enum::TokenNotFoundError: token 'invalid'' not found in the enum Side
Side.enum('invalid') # => Enum::TokenNotFoundError: token 'invalid'' not found in the enum Side
```

Get all defined enum values with the `all` method:

```ruby
Side.all # => [:left, :right]
```

> Order or the returned values in the same as their definition. It's guaranteed.

In order to get array of defined enums safely use `enums` method:

```ruby
 Side.enums(:left, :right) # => [{:left => "left"}, {:right => "right"}]
```
---
## TO ADAPT FROM MEZUKA, NOT YET IMPLEMENTED
Consider the case when we have an object with a field with only enum values. Extend the class of this object by `Enum::Predicates` and use `enumerize` method to generate predicates. This is a more convenient way matching current value of the field with an enum value. Usage the predicate methods is **safe** also. It means that you can't pass to the method invalid enum value neither can have an invalid value in the field:

```ruby
class Table
  extend Enum::Predicates

  attr_accessor :side

  enumerize :side, Side
end

@table = Table.new
@table.side_is?(:left) # => false
@table.side_is?(nil) # => false

@table.side = Side.enum(:left)
@table.side_is?(:left) # => true
@table.side_is?(:right) # => false
@table.side_is?(nil) # => false
@table.side_is?(:invalid) # => Enum::TokenNotFoundError: token 'invalid'' not found in the enum Side

@table.side = 'invalid'
@table.side_is?(nil) # => false
@table.side_is?(:left) # => Enum::TokenNotFoundError: token 'invalid'' not found in the enum Side
@table.side_any?(:left, :right) # => true
@table.side_any?(:right) # => false
@table.side_any?(:invalid, :left) # => Enum::TokenNotFoundError: token 'invalid'' not found in the enum Side
```
> If you pass to the predicate `nil` or have `nil` value in the field the result will be always `false`. If you want to check that the field is `nil` just use Ruby's standard method `nil?`.

It's possible to get index of an enum value with `index` method. It can be convenient in some circumstances:

```ruby
class WeekDay < Enum::Base
  values :sunday, :monday, :tuesday, :wednesday, :thusday, :friday, :saturday
end
WeekDay.index(:sunday) == Date.new(2015, 9, 13).wday # => true
WeekDay.index(:monday) # => 1
WeekDay.indexes # => [0, 1, 2, 3, 4, 5, 6]
```
---
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mezuka/enum. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


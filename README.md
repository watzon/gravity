# Gravity (WIP)

Gravity is the first annotation based ORM for Crystal. The goal of Gravity is to stay out of your way and allow you to create models in the same way that you'd create JSON serializable objects.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     gravity:
       github: watzon/gravity
   ```

2. Run `shards install`

## Usage

```crystal
require "gravity"

# Require the driver you want
require "gravity-postgres"

# Configure Gravity
Gravity.configure do
  register_driver "pg", Gravity::Driver::Postgres do
    username "admin"
    password "password"
    host     "localhost"
    port     5432
  end

  set_default_driver "pg"
end

# Create a model
class User
  include Gravity::Model

  @[Gravity::Column(primary: true)]
  property id : Int64

  property first_name : String

  property last_name : String

  # With a default value
  property language_code : String = "en"

  # Has many with lazy loading
  @[Gravity::HasMany(Chat, lazy: true)]
  property chats : Array(Chat)
end

# By default the table name will be the lowercased, pluralized form of
# the class name. To change that, use the `Gravity::Table` annotation.
@[Gravity::Table(name: "mychats")]
class Chat
  include Gravity::Model

  @[Gravity::Column(primary: true)]
  property id : UUID = UUID.random

  property title : String

  @[Gravity::BelongsTo(User)]
  property user : User
end

# Create a new User
user = User.new(id: 1234, first_name: "John", last_name: "Doe")

# Insert it into the database (throwing on failure)
user.save!

# Create a new Chat
chat = Chat.new(title: "Test chat", user: user)

# Insert it into the database as well
chat.save!

# Query the database for the User
user = User.where(first_name: "John") # will return an Array of matches
user = User.find_one(id: 1234) # will return a single match

# Modify the User
user.first_name = "Joe"

# Update it in the database (throwing on failure)
user.save!
```

## Supported Types

 - `Int` _(all types)_
 - `UInt` _(all types)_
 - `Float` _(all types)_
 - `Enum`
 - `Bytes`
 - `String`
 - `JSON::Any`
 - `YAML::Any`
 - `UUID`
 - `URI`
 - `BigInt`
 - `BigFloat`
 - `BigDecimal`
 - `BigRational`

## Migrations

TODO

## Contributing

1. Fork it (<https://github.com/watzon/gravity/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Chris Watson](https://github.com/watzon) - creator and maintainer

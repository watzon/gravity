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

# Create a model
class User
  include Gravity::Model

  @[Gravity::Field(primary: true)]
  property id : Int64

  property first_name : String

  property last_name : String

  # With a default value
  property language_code : String = "en"

  # Has many with lazy loading
  @[Gravity::HasMany(lazy: true)]
  property chats : Chat = [] of Chat

  # BelongsTo associations are inferred from other models
  # with HasMany associations
end

class Chat
  include Gravity::Model

  @[Gravity::Field(primary: true)]
  property id : Int64

  property title : String
end
```

## Contributing

1. Fork it (<https://github.com/watzon/gravity/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Chris Watson](https://github.com/watzon) - creator and maintainer

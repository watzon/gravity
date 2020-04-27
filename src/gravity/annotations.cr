module Gravity
  # Class annotation to set the table a model belongs to. By default,
  # models will be assigned to a table name that is a lowercased,
  # pluralized version of their name. So the model `Foo` would
  # be attached to the table `foos`.
  #
  # Example:
  # ```
  # @[Gravity::Table("bazes")]
  # class Foo
  #   include Gravity::Model
  # end
  # ```
  #
  annotation Table; end

  # This is akin to the `JSON::Field` annotation for the `JSON::Serializable`
  # module. It annotates a `getter`, `setter`, or `property` and allows you
  # to change how that item is seen (or not seen) by the model. The
  # available params are:
  #
  # - `primary` - If true, this field will be the primary key.
  # - `index` - If true, this field will be indexed.
  # - `ignore` - If true, the field should be ignored. It will not be attached to the database.
  # - `lazy` - If true, the value of the field will not be loaded until it's requested.
  # - `name` - The name of the field in the database.
  # - `converter` - A converter module to be applied to the field. The converter must define
  #   `self.from_qr(Gravity::QueryResult)` and `self.to_qr(value, Gravity::QueryResultBuilder)` methods.
  #
  # Example:
  # ```
  # class User
  #   include Gravity::Model
  #
  #   getter name : String
  #
  #   @[Gravity::Column(ignore: true)]
  #   getter hidden_field : String
  # end
  # ```
  #
  annotation Column; end

  # Creates a has one association on the model.
  annotation HasOne; end

  # Creates a has many association on the model.
  annotation HasMany; end

  # Counterpart to `HasOne` and `HasMany`.
  annotation BelongsTo; end
end

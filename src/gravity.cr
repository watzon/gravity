# TODO: Write documentation for `Gravity`
module Gravity
  @@registered_drivers = {} of String => Gravity::Driver::Base

  @@default_driver : Gravity::Driver::Base?

  def self.register_driver(name : String | Symbol, type : Gravity::Driver::Base, **kwargs)
    driver = type.new(**kwargs)
    @@registered_drivers[name.to_s] = driver
  end

  def self.register_driver(name : String | Symbol, type : Gravity::Driver::Base, &block)
    driver = type.new
    with driver yield driver
    @@registered_drivers[name.to_s] = driver
  end

  def self.set_default_driver(name : String)
    if driver = @@registered_drivers[name]?
      @@default_driver = driver
    else
      raise "Failed to set default driver"
    end
  end

  def self.default_driver
    @@default_driver ||= @@registered_drivers.values.first
    if default = @@default_driver
      return default
    end
    raise "Failed to set default driver"
  end

  def self.configure(&block)
    with self yield self
  end
end

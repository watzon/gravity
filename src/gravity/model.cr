module Gravity
  module Model
    def initialize(**properties)
      {% begin %}
        {% props = {} of Nil => Nil %}
        {% for ivar in @type.instance_vars %}
          {% column = ivar.annotation(Gravity::Column) %}
          {% unless column && column[:ignore] %}
            {%
              props[ivar.id] = {
                type:        ivar.type,
                name:        ((column && column[:name]) || ivar).id.stringify,
                has_default: ivar.has_default_value?,
                default:     ivar.default_value,
                nilable:     ivar.type.nilable?,
                converter:   column && column[:converter],
              }
            %}
          {% end %}
        {% end %}

        {% for name, value in props %}
          %var{name} = properties[{{ name.symbolize }}]? || {{ value[:has_default] ? value[:default] : nil }}
          {% unless value[:nilable] %}
            raise "Property {{ name }} is not nilable, but no value was given" if %var{name}.nil?
          {% end %}
          @{{ name }} = %var{name}
        {% end %}
      {% debug %}
      {% end %}
    end

    def self.create(**properties)
      new(**properties).save
    end

    def self.create(**properties)
      new(**properties).save!
    end

    def table_name
      {% begin %}
        {% table = @type.annotation(Gravity::Table) %}
        {{ table ? table[:name] : @type.name.underscore }}
      {% end %}
    end

    def driver
      {% begin %}
        {% table = @type.annotation(Gravity::Table) %}
        driver = {{ table ? table[:driver] : Gravity.default_driver }}
        driver.is_a?(Gravity::driver) ? driver : Gravity.named_driver(driver)
      {% end %}
    end

    def find(id)
      QueryBuilder.with(self).find(id)
    end

    def take
    end

    def take(count)
    end

    def first
    end

    def first(count)
    end

    def last
    end

    def last(count)
    end

    def where(**conditions)
    end

    def raw(sql)
    end

    def save
    end

    def save!
    end
  end
end

require "./gravity/*"

module Gravity
  def self.configure(&block)
    with self yield self
  end
end

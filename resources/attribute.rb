actions :define

attribute :name, :kind_of => String, :name_attribute => true
attribute :namespace, :default => "preferred"

def initialize(*args)
  super
  @action = :define
  @_blocks = Array.new
end

def maybe(&blk)
  @_blocks << blk
end

def blocks
  @_blocks
end

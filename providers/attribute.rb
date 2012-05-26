action :define do
  # evaluate each block in turn, using the first one
  # which returns a non-nil value as the value to set
  value = new_resource.default
  new_resource.blocks.each do |the_block|
    begin
      value = the_block.call
    rescue
      next
    end
    break if !value.nil?
  end

  # find the right spot in the node attribute tree to
  # set our new value
  obj = node
  parts = new_resource.name.split('.')
  parts, lastpart = parts[0..-2], parts[-1]
  parts.each do |part|
    obj[part] = Hash.new if !obj.include?(part)
    obj = obj[part]
  end

  # but only set it if it's changed
  if obj.include?(lastpart) && obj[lastpart] != value
    obj[lastpart] = value
    new_resource.updated_by_last_action(true)
  end
end

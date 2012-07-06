action :define do
  # Evaluate each block in turn, using the first one
  # which returns a non-nil value as the value to set
  value = nil
  new_resource.blocks.each do |the_block|
    begin
      value = the_block.call
    rescue
      next
    end
    break if !value.nil?
  end

  if value
    # Traverse all but the last part of the
    # (possibly) dotted attribute path, creating
    # empty Hashes along the way as needed
    parts = new_resource.name.split('.')
    parts, lastpart = parts[0..-2], parts[-1]
    parts.insert(0, new_resource.namespace) if !new_resource.namespace.nil?

    obj = node
    parts.each do |part|
      obj[part] = Hash.new if !obj.include?(part)
      obj = obj[part]
    end

    # Finally, set the attribute to the desired
    # value, and mark the resource as changed
    if !obj.include?(lastpart) || obj[lastpart] != value
      Chef::Log.info("preferred_attribute[#{new_resource.name}] => #{value.inspect}")
      obj[lastpart] = value
      new_resource.updated_by_last_action(true)
    end
  end
end

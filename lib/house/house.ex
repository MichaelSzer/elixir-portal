defmodule House do
  def get_attributes(added_attributes, requested_attributes) do
    attributes = added_attributes ++ [size: 'medium', floors: 3, has_garage: true, color: 'red']
    Enum.map(requested_attributes, fn attr -> attributes[attr] end)
  end
end

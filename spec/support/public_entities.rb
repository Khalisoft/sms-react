class PublicEntity
  def self.serialize(obj, options={})
    ActiveModelSerializers::SerializableResource.new(
      obj,
      options
    ).as_json
  end
end

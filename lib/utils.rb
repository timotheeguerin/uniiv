module Utils
  class << self
    def element_id(object)
      "#{object.class}.#{object.id}"
    end

    def from_element_id(string)
      class_name, id = string.split('.')
      clazz = class_name.safe_constantize
      return nil if clazz.nil?
      clazz.find_by_id(id)
    end
  end
end
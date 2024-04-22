# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(attr_name, validation_type, *args)
      @validations ||= []
      @validations << { attr_name:, type: validation_type, args: }
    end
  end

  module InstanceMethods
    def validate!
      base_class = self.class.superclass == Object ? self.class : self.class.superclass
      base_class.validations.each do |validation|
        attr_name = validation[:attr_name]
        method = "validate_#{validation[:type]}"
        value = instance_variable_get("@#{attr_name}")
        args = validation[:args]

        send(method, attr_name, value, *args)
      end
    end

    def valid?
      validate!
      true
    rescue StandardError => e
      puts e.message
      false
    end

    private

    def validate_presence(attr_name, value)
      raise "Value for #{attr_name} cannot be empty" if value == ''
    end

    def validate_format(attr_name, value, format)
      raise "Value for #{attr_name} does not match format ***-**" unless value =~ format
    end

    def validate_type(attr_name, value, type)
      raise "Value for #{attr_name} is not of type #{type}" unless value.is_a?(type)
    end
  end
end

# frozen_string_literal: true

module Accessor
  require_relative './validation'

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        history_var_name = "@#{name}_history"

        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=") do |value|
          history = instance_variable_get(history_var_name) || []
          instance_variable_set(history_var_name, history << value)
          instance_variable_set(var_name, value)
        end
      end
    end

    def strong_attr_accessor(attr_name, klass)
      define_method(attr_name) do
        instance_variable_get("@#{attr_name}")
      end

      define_method("#{attr_name}=") do |value|
        # raise TypeError, "Expected #{klass}, got #{value.class}" unless value.is_a?(klass)
        Validation.validate_type(value, klass)
        instance_variable_set("@#{attr_name}", value)
      end
    end
  end
end

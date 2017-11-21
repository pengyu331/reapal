# coding: utf-8
module Reapal
  module Http

    class Response
      attr_accessor :service, :flow_id
      attr_accessor :http_response, :raw_body
      attr_accessor :data, :data_valid

      def initialize(params)
        self.data_valid = true
        
        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def [] key
        instance_variable_get("#{key}")
      end

      def to_s
        arr = ["{"]
        self.instance_variables.map{ |value|
          arr << "\t#{value.to_s} => #{self[value.to_sym]}"
        }
        arr << ["}"]
        arr.join("\n")
      end

    end

  end
end

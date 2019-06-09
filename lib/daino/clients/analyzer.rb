# frozen_string_literal: true

module Daino
  module Clients
    class Analyzer < Base
      def list
        get("/api/analyzer") { |json| json }
      end

      def search(attributes)
        post("/api/analyzer/_search", query: attributes) { |json| json }
      end

      def get_by_id(id)
        get("/api/analyzer/#{id}") { |json| json }
      end

      def get_by_name(name)
        search(name: name)&.first
      end

      def get_by_type(type)
        get("/api/analyzer/type/#{type}") { |json| json }
      end

      def run_by_id(id, data:, data_type:, tlp: 0, message: nil, parameters: nil, force: nil)
        payload = {
          data: data,
          dataType: data_type,
          tlp: tlp,
          message: message,
          parameters: parameters
        }.compact

        options = force.nil? ? {} : { force: force }

        post("/api/analyzer/#{id}/run", payload, options) { |json| json }
      end

      def run_by_name(name, data:, data_type:, tlp: 0, message: nil, parameters: nil, force: nil)
        analyzer = get_by_name(name)
        raise ArgumentError, "#{name} does not exist." unless analyzer

        id = analyzer.dig("id")
        run_by_id(id, data: data, data_type: data_type, tlp: tlp, message: message, parameters: parameters, force: force)
      end
    end
  end
end

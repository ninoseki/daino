# frozen_string_literal: true

module Daino
  module Clients
    class Job < Base
      def list(range: "all")
        search({}, range: range)
      end

      def search(attributes, range: "all")
        post("/api/job/_search", attributes, range: range) { |json| json }
      end

      def get_by_id(id)
        get("/api/job/#{id}") { |json| json }
      end

      def report(id)
        get("/api/job/#{id}/report") { |json| json }
      end

      def artifacts(id)
        get("/api/job/#{id}/artifacts") { |json| json }
      end

      def delete_by_id(id)
        delete("/api/job/#{id}") { |json| json }
      end
    end
  end
end

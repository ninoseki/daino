# frozen_string_literal: true

module Daino
  module Clients
    class Organization < Base
      def list
        get("/api/organization") { |json| json }
      end

      def search(attributes)
        post("/api/organization/_search", query: attributes) { |json| json }
      end

      def get_by_id(id)
        get("/api/organization/#{id}") { |json| json }
      end

      def users(id)
        get("/api/organization/#{id}/user") { |json| json }
      end

      def create(name:, description:, status: "Active")
        payload = { name: name, description: description, status: status }
        post("/api/organization", payload) { |json| json }
      end

      def delete_by_id(id)
        delete("/api/organization/#{id}") { |res| res }
      end
    end
  end
end

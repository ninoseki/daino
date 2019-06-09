# frozen_string_literal: true

module Daino
  module Clients
    class User < Base
      def list
        get("/api/user") { |json| json }
      end

      def search(attributes)
        post("/api/user/_search", query: attributes) { |json| json }
      end

      def get_by_name(name)
        get("/api/user/#{name}") { |json| json }
      end

      def create(name:, roles:, organization:, login:, status: "Ok")
        payload = {
          name: name,
          roles: roles,
          organization: organization,
          login: login,
          status: status
        }
        post("/api/user", payload) { |json| json }
      end
    end
  end
end

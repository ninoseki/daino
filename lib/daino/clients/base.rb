# frozen_string_literal: true

require "json"
require "net/https"

module Daino
  module Clients
    class Base
      attr_reader :api_endpoint
      attr_reader :api_key

      def initialize(api_endpoint:, api_key:)
        @api_endpoint = URI(api_endpoint)
        @api_key = api_key
      end

      private

      def base_url
        "#{api_endpoint.scheme}://#{api_endpoint.hostname}:#{api_endpoint.port}"
      end

      def url_for(path)
        URI(base_url + path)
      end

      def https_options
        return nil if api_endpoint.scheme != "https"

        if proxy = ENV["HTTPS_PROXY"] || ENV["https_proxy"]
          uri = URI(proxy)
          {
            proxy_address: uri.hostname,
            proxy_port: uri.port,
            proxy_from_env: false,
            use_ssl: true,
          }
        else
          { use_ssl: true }
        end
      end

      def http_options
        if proxy = ENV["HTTP_PROXY"] || ENV["http_proxy"]
          uri = URI(proxy)
          {
            proxy_address: uri.hostname,
            proxy_port: uri.port,
            proxy_from_env: false,
          }
        else
          {}
        end
      end

      def parse_body(body)
        JSON.parse body.to_s
      rescue JSON::ParserError => _e
        body.to_s
      end

      def request(req)
        Net::HTTP.start(api_endpoint.hostname, api_endpoint.port, https_options || http_options) do |http|
          response = http.request(req)
          json = parse_body(response.body)

          raise(Error, "Unsupported response code returned: #{response.code} (#{json&.dig('message')})") unless response.code.start_with? "20"

          yield json
        end
      end

      def get(path, params = {}, &block)
        url = url_for(path)
        url.query = URI.encode_www_form(params) unless params.empty?

        get = Net::HTTP::Get.new(url)
        get.add_field "Authorization", "Bearer #{api_key}"
        request(get, &block)
      end

      def post(path, data, params = {}, &block)
        url = url_for(path)
        url.query = URI.encode_www_form(params) unless params.empty?

        post = Net::HTTP::Post.new(url)
        post.body = data.is_a?(Hash) ? data.to_json : data.to_s

        post.add_field "Content-Type", "application/json"
        post.add_field "Authorization", "Bearer #{api_key}"

        request(post, &block)
      end

      def delete(path, params = {}, &block)
        url = url_for(path)
        url.query = URI.encode_www_form(params) unless params.empty?

        delete = Net::HTTP::Delete.new(url)
        delete.add_field "Authorization", "Bearer #{api_key}"
        request(delete, &block)
      end
    end
  end
end

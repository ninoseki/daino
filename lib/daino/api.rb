# frozen_string_literal: true

module Daino
  class API
    attr_reader :job
    attr_reader :analyzer
    attr_reader :organization

    def initialize(api_endpoint: ENV["CORTEX_API_ENDPOINT"], api_key: ENV["CORTEX_API_KEY"])
      raise(ArgumentError, "api_endpoint argument is required") unless api_endpoint
      raise(ArgumentError, "api_key argument is required") unless api_key

      @job = Clients::Job.new(api_endpoint: api_endpoint, api_key: api_key)
      @analyzer = Clients::Analyzer.new(api_endpoint: api_endpoint, api_key: api_key)
      @organization = Clients::Organization.new(api_endpoint: api_endpoint, api_key: api_key)
      @user = Clients::User.new(api_endpoint: api_endpoint, api_key: api_key)
    end
  end
end

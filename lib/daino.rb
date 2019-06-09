# frozen_string_literal: true

require "daino/version"

require "daino/clients/base"
require "daino/clients/job"
require "daino/clients/analyzer"
require "daino/clients/organization"
require "daino/clients/user"

require "daino/api"

module Daino
  class Error < StandardError; end
end

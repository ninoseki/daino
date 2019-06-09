# frozen_string_literal: true

RSpec.describe Daino::Clients::Organization, :vcr do
  let(:api) { Daino::API.new }
  let(:id) { "test" }

  include_context "with super admin"

  describe "#list" do
    it do
      res = api.organization.list
      expect(res).to be_an(Array)
    end
  end

  describe "#search" do
    it do
      res = api.organization.search(status: "Active")
      expect(res).to be_an(Array)
    end
  end

  describe "#get_by_id" do
    it do
      res = api.organization.get_by_id(id)
      expect(res).to be_a(Hash)
    end
  end

  describe "#users" do
    it do
      res = api.organization.users(id)
      expect(res).to be_an(Array)
    end
  end

  describe "#create" do
    let(:name) { "create" }
    let(:description) { "create" }

    it do
      res = api.organization.create(name: name, description: description)
      expect(res).to be_a(Hash)
    end
  end

  describe "#delete" do
    let(:name) { "delete" }
    let(:description) { "delete" }

    before { api.organization.create(name: name, description: description) }

    it do
      res = api.organization.delete_by_id(name)
      expect(res).to be_a(String)
    end
  end
end

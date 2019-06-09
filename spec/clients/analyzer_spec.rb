# frozen_string_literal: true

RSpec.describe Daino::Clients::Analyzer, :vcr do
  let(:api) { Daino::API.new }
  let(:id) { "e50a2b57188e8c4e05abb5175fac6a26" }
  let(:name) { "Urlscan_io_Search_0_1_0" }
  let(:payload) { { data: "1.1.1.1", data_type: "ip", tlp: 0 } }

  describe "#list" do
    it do
      res = api.analyzer.list
      expect(res).to be_an(Array)
    end
  end

  describe "#search" do
    it do
      res = api.analyzer.search(name: "Urlscan_io_Search_0_1_0")
      expect(res).to be_an(Array)
    end
  end

  describe "#get_by_id" do
    it do
      res = api.analyzer.get_by_id(id)
      expect(res).to be_a(Hash)
    end
  end

  describe "#get_by_type" do
    it do
      res = api.analyzer.get_by_type("ip")
      expect(res).to be_an(Array)
    end
  end

  describe "#run_by_id" do
    it do
      res = api.analyzer.run_by_id(id, payload)
      expect(res).to be_a(Hash)
    end
  end

  describe "#run_by_name" do
    it do
      res = api.analyzer.run_by_name(name, payload)
      expect(res).to be_a(Hash)
    end
  end
end

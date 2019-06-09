# frozen_string_literal: true

RSpec.describe Daino::Clients::User, :vcr do
  let(:api) { Daino::API.new }
  let(:id) { "AWr-bjRFdwl0qz9B4vL9" }

  describe "#get_by_id" do
    it do
      res = api.job.get_by_id(id)
      expect(res).to be_a(Hash)
    end
  end

  describe "#delete" do
    it do
      res = api.job.delete_by_id(id)
      # expect(res.empty?).to eq(true)
    end
  end

  describe "#list" do
    it do
      res = api.job.list
      expect(res).to be_an(Array)
    end
  end

  describe "#artifacts" do
    it do
      res = api.job.artifacts(id)
      expect(res).to be_an(Array)
    end
  end
end

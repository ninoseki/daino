# frozen_string_literal: true

RSpec.shared_context "with super admin" do
  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("CORTEX_API_KEY").and_return(ENV["CORTEX_SUPER_ADMIN_API_KEY"])
  end
end

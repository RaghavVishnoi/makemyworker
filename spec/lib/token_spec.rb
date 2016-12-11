require "spec_helper"
require SPEC_ROOT.join("../lib/token")

describe Token do
  context "#generate" do
    it "returns a 20-byte token" do
      token = Token.new.generate
      other_token = Token.new.generate

      expect(token.size).to eq 40
      expect(token).to match /\A[a-f0-9]+\Z/
      expect(token).not_to eq other_token
    end
  end
end

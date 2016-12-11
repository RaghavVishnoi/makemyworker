class GigToken
  def self.generate
    SecureRandom.hex(3)
  end
end
# over writing the conflict slug
module FriendlyId
  module Slugged
    def resolve_friendly_id_conflict(candidates)
      candidates.first + friendly_id_config.sequence_separator + SecureRandom.hex(3)
    end
  end
end
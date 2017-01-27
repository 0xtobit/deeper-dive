class Match < ActiveRecord::Base
  belongs_to :summoner, inverse_of: :matches
  # TODO uniqueness
end

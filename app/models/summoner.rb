class Summoner < ActiveRecord::Base
  has_many :matches, inverse_of: :summoner
  # TODO uniqueness
end

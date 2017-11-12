class Participant < ActiveRecord::Base
  belongs_to :match, inverse_of: :participants
end

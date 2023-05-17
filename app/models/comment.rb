class Comment < ApplicationRecord
  include Status
  
  belongs_to :article
end

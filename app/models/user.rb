class User < ApplicationRecord
  has_many :auth_tokens
end

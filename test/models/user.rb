class User < ActiveRecord::Base
  include ActiveModel::SecureToken
  has_secure_token
  has_secure_token :auth_token
end

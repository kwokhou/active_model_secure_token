class Post
  include Mongoid::Document
  include ActiveModel::SecureToken

  field :token, type: String
  field :auth_token, type: String

  has_secure_token
  has_secure_token :auth_token
end

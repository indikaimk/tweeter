module Tweeter
  class Account < ApplicationRecord
    belongs_to :publisher, class_name: Tweeter.publisher_class.to_s
    encrypts :api_key
    encrypts :api_key_secret
    encrypts :access_token
    encrypts :access_token_secret

    validates :api_key, presence: true
    validates :api_key_secret, presence: true
    validates :access_token, presence: true
    validates :access_token_secret, presence: true
    validates :publisher, presence: true
    validates :username, presence: true, uniqueness: { scope: :publisher_id }

    def get_credentials_hash 
      return { api_key: self.api_key, api_key_secret: self.api_key_secret, access_token: self.access_token, 
              access_token_secret: self.access_token_secret }
    end

    # before_validation :set_publisher

    # private
    #   def set_publisher
    #     self.publisher = Tweeter.publisher_class.constantize.find_or_create_by()
    #   end

  end
end

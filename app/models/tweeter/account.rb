module Tweeter
  class Account < ApplicationRecord
    belongs_to :newsletter
  end
end

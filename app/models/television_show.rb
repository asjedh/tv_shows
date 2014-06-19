class TelevisionShow < ActiveRecord::Base
  validates :title,
    presence: true,
    uniqueness: { scope: :network }

    has_many :characters, dependent: :destroy
end

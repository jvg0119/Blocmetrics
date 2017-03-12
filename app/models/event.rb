class Event < ApplicationRecord
  belongs_to :registered_application

  validates :name, presence: true 
  validates :name, uniqueness: { case_sensitive: false }

end

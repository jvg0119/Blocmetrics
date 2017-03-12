class RegisteredApplication < ApplicationRecord
  belongs_to :user#, optional: true   # remove later when sign in is implemented
  has_many :events, dependent: :destroy

  validates :name, :url, presence: true
  validates :name, :url, uniqueness: { case_sensitive: false }

end

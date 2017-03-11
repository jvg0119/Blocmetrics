class RegisteredApplication < ApplicationRecord
  belongs_to :user#, optional: true   # remove later when sign in is implemented

  validates :name, :url, presence: true
  validates :name, :url, uniqueness: { case_sensitive: false }

end


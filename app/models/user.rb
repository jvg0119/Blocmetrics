class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,  :confirmable 

  has_many :registered_applications

  validates :name, presence: true

end

# t.string   "name"
#     t.string   "email",                  default: "", null: false
#     t.string   "encrypted_password",    



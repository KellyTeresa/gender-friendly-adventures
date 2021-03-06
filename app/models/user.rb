class User < ActiveRecord::Base
  has_many :reviews
  validates :display_name,
    presence: true,
    length: { in: 2..100 },
    uniqueness: true
  validates :admin, inclusion: { in: [true, false] }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
end

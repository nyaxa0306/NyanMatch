class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :cats, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_cats, through: :favorites, source: :cat

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, length: { maximum: 20 }, presence: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :introduction, length: { maximum: 300 }

  enum role: { adopter: 0, protector: 1 } # adopter=里親希望  protector=保護主
end

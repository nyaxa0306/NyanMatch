class Cat < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  belongs_to :user
  has_one_attached :image

  validates :name, length: { maximum: 20 }, presence: true
  validates :age, :gender, :prefecture_id, presence: true
  validates :gender, inclusion: { in: %w[male female] }
  validates :breed, length: { maximum: 50 }
  validates :personality, :helth, length: { maximum: 100 }

  after_initialize :set_default_status, if: :new_record?

  def display_age
    "#{age}歳" if age.present?
  end

  def display_image(width: 400, height: 300)
    if image.attached?
      image.variant(resize_to_limit: [width, height])
    else
      ActionController::Base.helpers.asset_path("default_cat.jpg")
    end
  end

  private

  def set_default_status
    self.status ||= "募集中"
  end
end

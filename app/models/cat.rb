class Cat < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, :age, :gender, presence: true
  validates :gender, inclusion: { in: %w[male female], allow_blank: true }

  after_initialize :set_default_status, if: :new_record?

  def display_age
    "#{age}歳" if age.present?
  end

  def display_image(width: 400, height: 300)
    if image.attached?
      image.variant(resize_to_limit: [width, height]).processed
    else
      ActionController::Base.helpers.asset_path("default_cat.jpg")
    end
  end

  private

  def set_default_status
    self.status ||= "募集中"
  end
end

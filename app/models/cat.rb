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

  # 検索処理
  scope :with_keyword, ->(keyword) {
    return all unless keyword.present?
    kw = "%#{keyword}%"
    where("name LIKE ? OR breed LIKE ? OR personality LIKE ?", kw, kw, kw)
  }

  scope :with_prefecture, ->(prefecture_id) {
    return all unless prefecture_id.present?
    where(prefecture_id: prefecture_id)
  }

  scope :with_gender, ->(gender) {
    return all unless gender.present?
    where(gender: gender)
  }

  scope :with_status, ->(status) {
    return all unless status.present?
    where(status: status)
  }

  def self.search(params)
    Cat
      .with_keyword(params[:keyword])
      .with_prefecture(params[:prefecture_id])
      .with_gender(params[:gender])
      .with_status(params[:status])
      .order(created_at: :desc)
  end

  private

  def set_default_status
    self.status ||= "募集中"
  end
end

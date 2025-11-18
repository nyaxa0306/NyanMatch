class Application < ApplicationRecord
  belongs_to :user
  belongs_to :cat

  validates :message, length: { maximum:300 }, presence: true

  enum status: { pending: 0, approved: 1, rejected: 2 } #pending=未対応 approved=承認 rejected=却下

  def status_i18n
    I18n.t("activerecord.attributes.application.statuses.#{status}")
  end
end

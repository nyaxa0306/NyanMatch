class AddPrefectureIdToCats < ActiveRecord::Migration[7.2]
  def change
    add_column :cats, :prefecture_id, :integer
  end
end

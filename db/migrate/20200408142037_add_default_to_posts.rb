class AddDefaultToPosts < ActiveRecord::Migration[5.2]
  def up
    change_column_default(:posts, :status, true)
  end

  def down
    change_column_default(:posts, :status, nil)
  end
end

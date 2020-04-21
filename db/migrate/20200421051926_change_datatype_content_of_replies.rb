class ChangeDatatypeContentOfReplies < ActiveRecord::Migration[5.2]
  def change
    change_column :replies, :content, :text
  end
end

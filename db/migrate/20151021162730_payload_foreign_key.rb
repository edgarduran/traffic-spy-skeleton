class PayloadForeignKey < ActiveRecord::Migration
  def change
    add_column :payloads, :user_id, :string
  end
end

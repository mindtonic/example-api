class CreateSaves < ActiveRecord::Migration[5.2]
  def change
    create_table :saves do |t|
      t.references :board, index: true, foreign_key: true
      t.references :saved_board, index: true

      t.timestamps null: false
    end

    add_foreign_key :saves, :boards, column: :saved_board_id
    add_index :saves, [:board_id, :saved_board_id], unique: true
  end
end

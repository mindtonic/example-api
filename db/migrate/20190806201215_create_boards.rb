class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.string :name
      t.text :description
      t.uuid :public_token, null: false

      t.timestamps
    end
    add_index :boards, :public_token, unique: true
  end
end

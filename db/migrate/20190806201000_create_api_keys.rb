class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :api_keys do |t|
      t.string :key
      t.string :secret
      t.string :ip_address
      t.boolean :active, default: true

      t.timestamps null: false
    end
    add_index :api_keys, :key
    add_index :api_keys, :secret
    add_index :api_keys, :active
    add_index :api_keys, [:key, :secret, :ip_address, :active]
  end
end

class AddSenderToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :sender, :string
  end
end

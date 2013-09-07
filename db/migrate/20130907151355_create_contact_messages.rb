class CreateContactMessages < ActiveRecord::Migration
  def change
    create_table :contact_messages do |t|
      t.string :author_name
      t.string :author_email
      t.text :message
      t.string :status

      t.timestamps
    end
  end
end

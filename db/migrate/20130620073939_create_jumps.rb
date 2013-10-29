class CreateJumps < ActiveRecord::Migration
  def change
    create_table :jumps do |t|
      t.string :cat
      t.timestamp :t

      t.timestamps
    end
  end
end

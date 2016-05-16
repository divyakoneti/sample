class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :f_name
      t.string :l_name
      t.string :email
      t.integer :contact
      t.text :address	

      t.timestamps null: false
    end
  end
end

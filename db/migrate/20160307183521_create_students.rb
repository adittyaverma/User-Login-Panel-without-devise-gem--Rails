class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :email,              :null => false, :default => ""
      t.string :password,           :null => false, :default => ""
      t.string :password_confirmation, :null => false, :default => ""
      #t.string :remember_me, :null => false, :default => ""
      
      t.timestamps
    end

  end
end

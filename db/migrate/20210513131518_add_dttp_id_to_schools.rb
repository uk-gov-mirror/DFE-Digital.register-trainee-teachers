class AddDttpIdToSchools < ActiveRecord::Migration[6.1]
  def change
    add_column :schools, :dttp_id, :uuid
  end
end

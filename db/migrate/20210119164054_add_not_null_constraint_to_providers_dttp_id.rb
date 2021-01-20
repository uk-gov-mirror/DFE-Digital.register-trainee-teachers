# frozen_string_literal: true

class AddNotNullConstraintToProvidersDttpId < ActiveRecord::Migration[6.1]
  def change
    # Give existing providers created by "rake example_data:generate" a fake DTTP entity ID
    Provider.where(dttp_id: nil).update_all(dttp_id: "00000000-0000-0000-0000-000000000000")
    change_column_null :providers, :dttp_id, false
  end
end

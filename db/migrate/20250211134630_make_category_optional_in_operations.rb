class MakeCategoryOptionalInOperations < ActiveRecord::Migration[8.0]
  def change
    change_column_null :operations, :category_id, true
  end
end

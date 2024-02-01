class CreateMilitaryFireds < ActiveRecord::Migration[7.1]
  def change
    create_view :military_fireds
  end
end

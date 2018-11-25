class AddBruttolonexsemesterToEzinvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :ezinvoices, :bruttol_exkl_semester_ef_avg, :integer
  end
end

class AddBruttolonexsemesterToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :bruttol_exkl_semester_ef_avg, :integer
  end
end

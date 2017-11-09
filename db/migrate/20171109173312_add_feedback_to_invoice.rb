class AddFeedbackToInvoice < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :feedback, :text
  end
end

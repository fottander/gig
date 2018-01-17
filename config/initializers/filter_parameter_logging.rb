# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password, :pers_num, :bank, :clear_nr, :account_nr, :email, :phone, :org_number, :company_email, :ocr_number, :amount]

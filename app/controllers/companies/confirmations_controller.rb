class Companies::ConfirmationsController < Devise::ConfirmationsController

  def new
    super
  end

  def create
    super
  end

  def show
    super
  end

  protected

    # The path used after resending confirmation instructions.
    def after_resending_confirmation_instructions_path_for(resource_name)
      is_navigational_format? ? new_company_session_path(resource_name) : '/'
    end

    # The path used after confirmation.
    def after_confirmation_path_for(resource_name, resource)
      if signed_in?(resource_name)
        signed_in_root_path(resource)
      else
        new_session_path(resource_name)
      end
    end

    def translation_scope
      'devise.confirmations'
    end
end

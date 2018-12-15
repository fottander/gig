class Companies::SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    super
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :alert, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.sign_in_count == 1
       new_job_path
    else
       panels_path
    end
  end

end

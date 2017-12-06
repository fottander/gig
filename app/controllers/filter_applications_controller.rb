class FilterApplicationsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @applications = Application.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @applications = @applications.public_send(key, value) if value.present?
    end
  end

  private

  def filtering_params(params)
    params.slice(:with_id, :with_job_id, :with_profile_id)
  end
end

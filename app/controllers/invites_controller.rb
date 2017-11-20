class InvitesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :authenticate_company!, only: [:new, :create]
  def new
    @invite = Invite.new
    @profile = Profile.find(params[:profile_id])
    @jobs = current_company.jobs.expired
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Hitta Frilansare', :profiles_path
    add_breadcrumb "#{@profile.username}".truncate(24), profile_path(@profile)
    add_breadcrumb 'Skapa Inbjudan'
  end

  def create
    @invite = Invite.new invite_params
    if @invite.save
      flash[:notice] = "Ny inbjudan skickad!"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def invite_params
    params.permit(:message, :job_title, :company_id, :profile_id)
  end
end

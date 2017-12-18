class InvitesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :authenticate_company!, only: [:new, :create]

  def index
    @profile = Profile.find(params[:profile_id])
    @invites = Invite.where(profile_id: @profile.id).paginate(page: params[:page])
  end

  def new
    @invite = Invite.new
    @profile = Profile.find(params[:profile_id])
    @jobs = current_company.jobs.expired
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Hitta Frilansare', :profiles_path
    add_breadcrumb @profile.username.truncate(24), profile_path(@profile)
    add_breadcrumb 'Skapa Inbjudan'
  end

  def create
    @invite = Invite.new invite_params
    @profile = Profile.find(params[:profile_id])
    @user = User.find_by(id: @profile.user_id)
    if @invite.save

      # Sends email to user when invite is created.
      NotificationMailer.job_invite_email(@user, @invite).deliver_now

      flash[:notice] = "Ny inbjudan skickad!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Fyll i alla fält korrekt!'
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def invite_params
    params.permit(:message, :job_id, :company_id, :profile_id)
  end
end

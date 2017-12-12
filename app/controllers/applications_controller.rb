class ApplicationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_admin!, only: [:index]

  def index
    @applications = Application.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @applications = @applications.public_send(key, value) if value.present?
    end
  end

  def new
    @application = Application.new
    @job = Job.find(params[:job_id])
    @profile = Profile.find_by(user_id: current_user)
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Hitta Jobb', :jobs_path
    add_breadcrumb @job.title.truncate(24), job_path(@job)
    add_breadcrumb 'Skapa Ansökan'
  end

  def show
    @application = Application.find(params[:id])
    @job = Job.find(params[:job_id])
    @comments = Comment.where(application_id: @application)
    @profile = Profile.find_by(user_id: current_user)
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Hitta Jobb', :jobs_path
    add_breadcrumb @job.title.truncate(24), job_path(@job)
    add_breadcrumb "ID #{@job.id}"
  end

  def create
    @job = Job.find(params[:job_id])
    @company = Company.find_by(id: @job.company_id)
    @application = Application.new application_params
    @application.job_id = @job.id
    @application.profile_id = current_user.profile.id
    @application.profile_username = current_user.profile.username
    @application.job_title = @job.title
    respond_to do |format|
      if @application.save

        # Sends email to company when application is created.
        NotificationMailer.new_application_email(@company, @job).deliver_now

        format.html { redirect_to dashboards_path, notice: 'Ny ansökan skickad!' }
        format.json { render :new, status: :created}
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
    @application = Application.find(params[:id])
    @application.complete = true
    @profile = Profile.find_by(id: @application.profile_id)
    @user = User.find_by(id: @profile.user_id)
    if @application.save

      # Sends email to user when job is completed.
      NotificationMailer.job_completed_email(@user, @application).deliver_now

      flash[:notice] = "Grattis! Jobb genomfört."
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.hired = true
    @profile = Profile.find_by(id: @application.profile_id)
    @user = User.find_by(id: @profile.user_id)
    if @application.save

      # Sends email to user when profile is hired.
      NotificationMailer.hired_email(@user, @application).deliver_now

      flash[:notice] = "Grattis! Du har anlitat personen."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    @application = Application.find(params[:id])
    if @application.destroy
      flash[:notice] = "Ansökan raderad!"
      redirect_back(fallback_location: dashboards_path)
    end
  end

  private

  def application_params
    params.require(:application).permit(:message)
  end

  def filtering_params(params)
    params.slice(:with_id, :with_job_id, :with_profile_id)
  end
end

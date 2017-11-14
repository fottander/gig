class ApplicationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @application = Application.new
    @job = Job.find(params[:job_id])
    @profile = Profile.find_by(user_id: current_user)
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Hitta Jobb', :jobs_path
    add_breadcrumb "#{@job.title}".truncate(24), job_path(@job)
    add_breadcrumb 'Skapa Ansökan'
  end

  def show
    @application = Application.find(params[:id])
    @job = Job.find(params[:job_id])
    @comments = Comment.where(application_id: @application)
    @profile = Profile.find_by(user_id: current_user)
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Hitta Jobb', :jobs_path
    add_breadcrumb "#{@job.title}".truncate(24), job_path(@job)
    add_breadcrumb "ID #{@job.id}"
  end

  def create
    @job = Job.find(params[:job_id])
    @profile = Profile.find_by(user_id: current_user)
    @application = Application.new application_params
    @application.job_id = @job.id
    @application.profile_id = @profile.id
    @application.profile_username = @profile.username
    @application.job_title = @job.title
    respond_to do |format|
      if @application.save
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
    if @application.save
      flash[:notice] = "Grattis! Jobb genomfört."
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.hired = true
    if @application.save
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
end

class ApplicationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_company!, only: [:hire, :extend, :clone]
  before_action :authenticate_admin!, only: [:index]

  def index
    sleep 1
    @applications = Application.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @applications = @applications.public_send(key, value) if value.present?
    end
  end

  def new
    @application = Application.new
    @job = Job.find(params[:job_id])
    @applications = @job.applications ##//Denna styr så man inte kan se ansök knappen i application.new om man redan ansökt till det jobbet. Dvs går tillbaka av misstag.//##
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Hitta Jobb', :jobs_path
    add_breadcrumb @job.title.truncate(24), job_path(@job)
    add_breadcrumb 'Skapa Ansökan'
  end

  def show
    @application = Application.find(params[:id])
    @job = Job.find(params[:job_id])
    @comments = Comment.where(application_id: @application)
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Hitta Jobb', :jobs_path
    add_breadcrumb @job.title.truncate(24), job_path(@job)
    add_breadcrumb "ID #{@job.id}"
  end

  def create
    @job = Job.find(params[:job_id])
    @company = @job.company
    @application = Application.new application_params
    @application.job_id = @job.id
    @application.profile_id = current_user.profile.id
    @application.profile_username = current_user.profile.username
    @application.job_title = @job.title
    respond_to do |format|
      if @application.save
        @application.create_activity :create, owner: current_user.profile, recipient: @job.company

        # Sends email to company when application is created.
        NotificationMailer.new_application_email(@company, @job).deliver_now

        format.html { redirect_to dashboards_path, notice: 'Ny ansökan skickad! Vi skickar ett email när du får svar på ansökan. Status för ansökan hittar du i kontrollpanelen ⤴' }
        format.json { render :new, status: :created}
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def hire
    @application = Application.find(params[:id])
    @application.company_id = current_company.id
    @user = @application.profile.user
    if params[:first_day].present?
      if params[:last_day].present?
        if params[:salary].present?
          if @application.update application_hire_params
            @application.create_activity :update, owner: current_company, recipient: @application.profile, recipient_id: @user.id

            # Sends email to user when profile is hired.
            NotificationMailer.hired_email(@user, @application).deliver_now

            flash[:notice] = "Grattis! Du har anlitat personen."
            redirect_back(fallback_location: root_path)
          else
            flash[:alert] = 'Något gick fel. Kontrollera att du fyllt i alla fält korrekt eller kontakta kundtjänst.'
            redirect_back(fallback_location: root_path)
          end
        else
          flash[:alert] = "Lön måste fyllas i"
          redirect_back(fallback_location: root_path)
        end
      else
        flash[:alert] = "Sista dag måste fyllas i"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:alert] = "Startdag måste fyllas i"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @application = Application.find(params[:id])
    @job = @application.job
  end

  def update
    @application = Application.find(params[:id])
    @job = @application.job
    respond_to do |format|
      if @application.update application_update_params
        format.html { redirect_to edit_job_application_path(@application.job, @application), notice: 'Ansökan ändrad' }
        format.json { render :edit, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def extend
    @application = Application.find(params[:id])
    @job = @application.job
    if @application.update application_extend_params
      @application.create_activity :extend, owner: current_company, recipient: @application.profile, recipient_id: @application.profile.user.id

      # Sends email to user when profile is hired.
      NotificationMailer.extend_email(@application.profile.user, @application).deliver_now

      flash[:notice] = "Ansökan förlängd!"
      redirect_to panels_path
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_to panels_path
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    @application = Application.find(params[:id])
    if @application.destroy
      flash[:notice] = "Ansökan raderad!"
      redirect_to dashboards_path
    else
      flash[:alert] = 'Något gick fel'
      redirect_to dashboards_path
    end
  end

  def revert
    @application = Application.find(params[:id])
    @job = Job.find(params[:job_id])
    @application.hired = false
    @application.first_day = ''
    @application.last_day = ''
    @application.salary = ''
    @application.add_ob = false
    if @application.save
      if current_user.present?
        @application.create_activity :revert, owner: current_user.profile, recipient: @job.company, recipient_id: @job.company.id

        # Sends email to company when application is deleted.
        NotificationMailer.revert_email(@job.company, @application).deliver_now
        flash[:notice] = "Anställningen raderad!"
        redirect_to dashboards_path
      else
        @application.create_activity :dehire, owner: current_company, recipient: @application.profile, recipient_id: @application.profile.user.id

        # Sends email to user when person is dehired.
        NotificationMailer.dehire_email(@application.profile.user, @application).deliver_now
        flash[:notice] = "Anställningen raderad!"
        redirect_to panels_path
      end
    else
      flash[:alert] = 'Något gick fel'
      redirect_to root_path
    end
  end

  def clone
    @application = Application.find(params[:id])
    if params[:first_day].present?
      if params[:last_day].present?
        if params[:salary].present?
          @new_application = @application.dup
          @new_application.update_attributes(dup_params)
          @new_application.hired = true
          @new_application.complete = false
          if @new_application.save
            @application.create_activity :clone, owner: current_company, recipient: @application.profile, recipient_id: @application.profile.user.id

            # Sends email to user when profile is hired.
            NotificationMailer.clone_email(@application.profile.user, @application).deliver_now

            flash[:notice] = "#{@new_application.profile_username} anställdes på nytt!"
            redirect_to panels_path
          else
            @new_application.destroy
            flash[:alert] = "Något gick fel. Kontrollera start och sista dag och försök igen eller kontakta kundtjänst."
            redirect_back(fallback_location: root_path)
          end
        else
          flash[:alert] = "Lön måste fyllas i"
          redirect_back(fallback_location: root_path)
        end
      else
        flash[:alert] = "Sista dag måste fyllas i"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:alert] = "Startdag måste fyllas i"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def dup_params
    params.permit(:first_day, :last_day, :salary)
  end

  def application_update_params
    params.require(:application).permit(:message)
  end

  def application_extend_params
    params.permit(:last_day)
  end

  def application_hire_params
    params.permit(:first_day, :last_day, :hired, :salary, :add_ob)
  end

  def application_params
    params.require(:application).permit(:message)
  end

  def filtering_params(params)
    params.slice(:with_id, :with_job_id, :with_profile_id)
  end
end

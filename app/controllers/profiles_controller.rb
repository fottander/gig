class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Alla Jobbsökare'
    sleep 1
    @profiles = Profile.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @profiles = @profiles.public_send(key, value) if value.present?
    end
  end

  def new
    @profile = Profile.new
    render layout: 'mobile_scroll_layout'
  end

  def show
    @profile = Profile.find(params[:id])
    @invoices = @profile.user.invoices.with_feedback.paginate(page: params[:with_feedback])
    add_breadcrumb 'Start', :root_path
    add_breadcrumb 'Alla Jobbsökare', :profiles_path
    add_breadcrumb @profile.username
  end

  def create
    @profile = Profile.new profile_params
    @profile.user_id = current_user.id
    respond_to do |format|
      if @profile.save
        format.html { redirect_to profile_path(@profile), notice: 'Ny profil skapad! Lägg gärna till mer info för att förbättra dina chanser. Lycka till med jobbsökandet!' }
        format.json { render :show, status: :created}
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @profile = Profile.find(params[:id])
    render layout: 'mobile_scroll_layout'
  end

  def update
    @profile = Profile.find(params[:id])
    respond_to do |format|
      if @profile.update profile_params
        format.html { redirect_to profile_path(@profile), notice: 'Profil redigerad!' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :age, {category_ids:[]}, :avatar, :description, :skill, :category, :city_ids, :language, :license, :education, :prev_work)
  end

  def filtering_params(params)
    params.slice(:with_category, :with_city)
  end

end

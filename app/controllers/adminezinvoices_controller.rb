class AdminezinvoicesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @ezinvoices = Ezinvoice.where(nil).paginate(page: params[:page])
    filtering_params(params).each do |key, value|
      @ezinvoices = @ezinvoices.public_send(key, value) if value.present?
    end
  end

  def show
    @ezinvoice = Ezinvoice.find(params[:id])
    @profiles = Profile.where(id: @ezinvoice.profile_id)
    @user = User.find_by(id: @ezinvoice.user_id)
    @due_date = @ezinvoice.updated_at+@ezinvoice.terms.day
    respond_to do |format|
      format.html
      format.pdf do
        pdf = EzinvoicePdf.new(@ezinvoice, @profiles, @due_date)
        send_data pdf.render, filename: "invoice_#{@ezinvoice.id}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end

  def pay
    @ezinvoice = Ezinvoice.find(params[:id])
    @ezinvoice.paid = true
    if @ezinvoice.update ezinvoice_pay_params
      flash[:notice] = "Faktura betald"
      redirect_back(fallback_location: administrations_path)
    end
  end

  def pay_salary
    @ezinvoice = Ezinvoice.find(params[:id])
    @ezinvoice.salary_paid = true
    if @ezinvoice.update ezinvoice_pay_salary_params
      flash[:notice] = "Lön har blivit utbetald"
      redirect_back(fallback_location: administrations_path)
    end
  end

  private

  def ezinvoice_pay_params
    params.permit(:paid)
  end

  def ezinvoice_pay_salary_params
    params.permit(:salary_paid)
  end

  def filtering_params(params)
    params.slice(:with_id, :with_user_id)
  end

end

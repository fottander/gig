class InvoicesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  before_action :authenticate_company!, only: [:extend, :feedback, :rating, :postal]

  def new
    @invoice = Invoice.new
    @application = Application.find_by(id: params[:application_id])
    @invoice.shifts.build
  end

  def create
    @invoice = Invoice.new invoice_params
    @application = Application.find(params[:invoice][:application_id])
    @company = @application.job.company
    @job = @application.job
    @invoice.application_id = @application.id
    @invoice.amount = 10
    @invoice.profile_id = current_user.profile.id
    @invoice.profile_username = current_user.profile.username
    @invoice.user_id = current_user.id
    @invoice.user_fee = current_user.fee
    @invoice.age = current_user.profile.years_old
    @invoice.add_ob = @application.add_ob
    @invoice.company_id = @job.company_id
    @invoice.job_id = @job.id
    @invoice.job_title = @job.title
    @invoice.first_day = @application.first_day
    @invoice.last_day = @application.last_day
    @invoice.company_reference = @job.company_username
    @invoice.user_reference = current_user.profile.username
    @invoice.description = @job.categories.pluck(:name).first
    @invoice.ssyk_code = @job.categories.pluck(:ssyk_code)
    respond_to do |format|
      if @invoice.save
        @application.update_attributes(complete: true)
        @invoice.update_attributes(quantity: @invoice.shifts.sum('quantity'))
        if @invoice.add_ob == true
          @invoice.update_attributes(amount: ((@invoice.shifts.sum('quantity') * @invoice.unit) + @invoice.shifts.sum('ob_amount')).to_i)
        else
          @invoice.update_attributes(amount: ((@invoice.shifts.sum('quantity') * @invoice.unit)).to_i)
        end
        @invoice.create_activity :create, owner: current_user.profile, recipient: @company

        # Sends email to company when invoice is created.
        NotificationMailer.new_invoice_email(@company, @invoice).deliver_now
        if current_user.bank_info == 'bank_info_ok'
          format.html { redirect_to dashboards_path, notice: "Utbetalning skapad!" }
          format.json { render :index, status: :created}
        else
          format.html { redirect_to dashboards_path, notice: "Utbetalning skapad. Fyll i personnummer & bankuppgifter i ditt konto för att erhålla lön." }
          format.json { render :index, status: :created}
        end
      else
        format.html { redirect_back fallback_location: new_invoice_path(application_id: @application.id), notice: "Något gick fel. Fyll i fälten korrekt och försök igen eller ring kundtjänst." }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
    @company = @invoice.company
    @profile = @invoice.user.profile
    @due_date = @invoice.due_date
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice, @profile, @company, @due_date)
        send_data pdf.render, filename: "invoice_#{@invoice.id}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    @company = Company.find_by(id: @invoice.company_id)
    respond_to do |format|
      if @invoice.update invoice_update_params
        @invoice.save
        @invoice.create_activity :update, owner: current_user.profile, recipient: @company
        format.html { redirect_to edit_invoice_path(@invoice), notice: 'Utbetalning ändrad' }
        format.json { render :edit, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def feedback
    @invoice = Invoice.find(params[:id])
    @user = @invoice.user
    if @invoice.update invoice_feedback_params
      if @invoice.paid == false
        @invoice.update(invoice_fees: @invoice.invoice_fees - 100)
        flash[:notice] = "Sparat!"
        redirect_back(fallback_location: panels_path)
      else
        flash[:notice] = "Sparat!"
        redirect_back(fallback_location: panels_path)
      end
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: panels_path)
    end
  end

  def rating
    @invoice = Invoice.find(params[:id])
    @user = @invoice.user
    if @invoice.update invoice_rating_params
      if @invoice.paid == false
        @invoice.update(invoice_fees: @invoice.invoice_fees - 100)
        flash[:notice] = "Sparat!"
        redirect_back(fallback_location: panels_path)
      else
        flash[:notice] = "Sparat!"
        redirect_back(fallback_location: panels_path)
      end
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: panels_path)
    end
  end


  def extend
    @invoice = Invoice.find(params[:id])
    @user = @invoice.user
    if @invoice.update invoice_extend_params
      if @invoice.terms == 20
        @invoice.update(invoice_fees: @invoice.invoice_fees + 500)
      end
      flash[:notice] = "Sparat!"
      redirect_back(fallback_location: panels_path)
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: panels_path)
    end
  end

  def postal
    @invoice = Invoice.find(params[:id])
    @user = @invoice.user
    if @invoice.update invoice_postal_params
      if @invoice.post == true
        @invoice.update(invoice_fees: @invoice.invoice_fees + 40)
      end
      flash[:notice] = "Sparat!"
      redirect_back(fallback_location: panels_path)
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: panels_path)
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    if @invoice.destroy
      flash[:notice] = "Utbetalning raderad!"
      redirect_back(fallback_location: dashboards_path)
    else
      flash[:alert] = 'Något gick fel. Försök igen eller kontakta kundtjänst.'
      redirect_back(fallback_location: dashboards_path)
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:quantity, :unit, :terms, :paid, :application_id, shifts_attributes: [:id, :_destroy, :start_date, :start_time, :end_date, :end_time])
  end

  def invoice_update_params
    params.require(:invoice).permit(:description, :quantity, :unit, :amount, :first_day, :last_day, :user_reference, :company_reference, :terms, :paid, :company_id, :application_id, :job_id, :job_title, :profile_id, :profile_username)
  end

  def invoice_feedback_params
    params.permit(:feedback)
  end

  def invoice_rating_params
    params.permit(:rating)
  end

  def invoice_extend_params
    params.permit(:terms)
  end

  def invoice_postal_params
    params.permit(:post)
  end
end

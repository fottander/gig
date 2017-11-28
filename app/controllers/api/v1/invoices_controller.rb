class Api::V1::InvoicesController < ApiController
  def index
    @invoices = Invoice.all
  end

  def show
    begin
      @invoice = Invoice.find(params[:id])
    rescue => error
      render json: { message: error}, status: 404
    end
  end
end

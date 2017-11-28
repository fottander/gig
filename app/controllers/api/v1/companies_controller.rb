class Api::V1::CompaniesController < ApiController
  def index
    @companies = Company.all
  end

  def show
    begin
      @company = Company.find(params[:id])
    rescue => error
      render json: { message: error}, status: 404
    end
  end
end

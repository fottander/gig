class PaymentPdf < Prawn::Document
  def initialize(invoice, user, profile, company)
    @invoice = invoice
    @user = user
    @profile = profile
    @company = company

    super(margin: 0)

    generate
  end

  private

  def generate
    bounding_box [0, 792], width: 700, height: 792 do
      bounding_box [85, 792], width: 650, height: 792 do
        header
        profile_info
        invoice_items
        footer
      end
    end
  end

  def header
    move_down 30

    image  "#{Rails.root}/app/assets/images/anewbiz-logo-2.png", width: 194

    move_down 8
    text "Lönebesked"
    move_down 10
    text "<color rgb='a6a6a6'>#{@user.first_name} #{@user.last_name}</color>", inline_format: true
    text "<color rgb='a6a6a6'>Startdag: #{@invoice.first_day}</color>", inline_format: true
    text "<color rgb='a6a6a6'>Sista dag: #{@invoice.last_day}</color>", inline_format: true
    text "<color rgb='a6a6a6'>Utbetalningsdatum: #{@invoice.updated_at.strftime("%F %R")}</color>", inline_format: true
    text "<color rgb='a6a6a6'>Bankkontonummer: #{@user.clear_nr} #{@user.account_nr}</color>", inline_format: true

  end

  def profile_info
    move_down 10

    data = [ ["Profil", "ID", "Jobb ID", "Företagsreferens", "Företag", "ssyk-kod"],
     ["#{@invoice.profile_username}", "#{@invoice.profile_id}", "#{@invoice.job_id}", "#{@invoice.company_reference}", "#{@company.name}", "#{@invoice.ssyk_code}"]]

    table(data, cell_style: { size: 10 }) do
     cells.padding = 6
     cells.borders = []
     row(0).font_style = :bold
    end
  end

  def invoice_items
    move_down 20
    @moms = @invoice.totalbelopp_inklmoms * 0.2
    if (25..64).include? @invoice.age
      @pension = (@invoice.bruttolon_ef_avg * 0.043).round
    end
    data = [ ["Beskrivning", "", "", "Bruttolön inkl semesterersättning"],
     [@invoice.description.first(25), "", "", @invoice.bruttolon_ef_avg],
     ["Skatt:", "", "", "-#{@invoice.loneskatt}"],
     ["Utbetald nettolön:", "", "", "#{@invoice.nettolon}"],
     ["Arbetsgivaravgifter:", "", "", "#{@invoice.arbetsgivaravgifter_ef_avg}"],
     ["Sociala avgifter(#{@invoice.soc_avgift_procent} %):", "", "", "#{@invoice.sociala_avgifter_ef_avg}"],
     ["Varav pensionsinbetalning:", "", "", "#{@pension}"]]

    table(data, cell_style: { size: 10 }) do
     cells.padding = 12
     cells.borders = []
     row(0).borders = [:bottom]
     row(0).border_width = 2
     row(0).font_style = :bold
     columns(0).width = 180
     columns(2).width = 80
     columns(3).width = 120
     columns(0).borders = [:left, :bottom]
     columns(1..2).borders = [:bottom]
     columns(3).borders = [:bottom, :right]
     row(0).columns(0).borders = [:bottom, :top, :left]
     row(0).columns(3).borders = [:bottom, :top, :right]
     row(0).columns(1..2).borders = [:bottom, :top]
     row(2..4).columns(0).borders = [:left]
     row(2..4).columns(3).borders = [:right]
     row(2..4).columns(1..2).borders = []
    end
  end


  def footer
    move_down 20

    data = [ ["Adress", "Telefon", "Säte", "Plusgiro"],
     ["FeltCap AB", "0707301078", "Göteborg", "86 40 62-5"],
     ["Storgatan 41, lgh 1101", "0735304864", "Org.nr", "Momsreg.nr"],
     ["41138, Göteborg", "Epost", "559129-6099","SE559129609901"],
     ["", "info@anewbiz.se", "Godkänd för F-skatt", ""]]

    table(data, cell_style: { size: 9 }) do
     cells.padding = 5
     cells.borders = []
     row(0).font_style = :bold
     row(2).columns(2).font_style = :bold
     row(2).columns(3).font_style = :bold
     row(3).columns(1).font_style = :bold
    end
  end
end

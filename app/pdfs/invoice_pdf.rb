class InvoicePdf < Prawn::Document
  def initialize(invoice, profile, company, due_date)
    @invoice = invoice
    @profile = profile
    @company = company
    @due_date = due_date

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
    text "<color rgb='a6a6a6'>Fakturanummer: #{@invoice.id.first(8)}</color>", inline_format: true
    move_down 10
    text "Datum: #{@invoice.updated_at.strftime('%F')}"
    text "Förfallodatum: #{@due_date.strftime('%F')}"
    text "Referens: #{@invoice.user_reference}"
    text "Er referens: #{@invoice.company_reference}"

    text "Kundnummer: #{@company.id}"
    text "#{@company.name}"
    if @company.invoice_address.present?
      text "#{@company.invoice_address}"
    else
      text "#{@company.address}"
    end
    text "#{@company.zip_code}, #{@company.city}"
  end

  def profile_info
    move_down 10

    data = [ ["Frilansare", "ID", "Jobb ID", "Startdag", "Sista dag", "ssyk-kod", "Förfallodatum"],
     ["#{@invoice.profile_username}", "#{@invoice.profile_id}", "#{@invoice.job_id}", "#{@invoice.first_day}", "#{@invoice.last_day}", "#{@invoice.ssyk_code}", "#{@due_date.strftime('%F')}"]]

    table(data, cell_style: { size: 10 }) do
     cells.padding = 6
     cells.borders = []
     row(0).font_style = :bold
    end
  end

  def invoice_items
    move_down 20
    @moms = @invoice.totalbelopp_inklmoms * 0.2
    data = [ ["Beskrivning", "Antal timmar", "Timlön", "Bruttolön inkl semesterersättning"],
     [@invoice.description, @invoice.quantity, @invoice.unit, @invoice.bruttolon],
     ["Arbetsgivaravgifter:", "", "", "#{@invoice.arbetsgivaravgifter}"],
     ["Sociala avgifter(#{@invoice.soc_avgift_procent} %):", "", "", "#{@invoice.sociala_avgifter}"],
     ["Löneskatt på pension:", "", "", "#{@invoice.pension_loneskatt}"],
     ["Fakturaavgifter:", "", "", "#{@invoice.invoice_fees}"],
     ["Totalsumma exkl. moms:", "", "", "#{@invoice.totalbelopp}"],
     ["Exkl. moms #{@invoice.totalbelopp}.00", "Moms(25%) #{@moms.round}.00", "", "Att betala: #{@invoice.totalbelopp_inklmoms}.00"]]

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
     row(5).columns(1..2).borders = [:bottom]
    end
  end


  def footer
    move_down 20

    data = [ ["Adress", "Telefon", "Säte", "Plusgiro", "OCR nummer"],
     ["FeltCap AB", "0707301078", "Göteborg", "86 40 62-5", "#{@invoice.ocr_number}"],
     ["Storgatan 41, lgh 1101", "0735304864", "Org.nr", "Momsreg.nr", ""],
     ["41138, Göteborg", "Epost", "559129-6099","SE559129609901", ""],
     ["", "info@anewbiz.se", "Godkänd för F-skatt", "", ""]]

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

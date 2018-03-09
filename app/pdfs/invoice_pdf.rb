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
    bounding_box [0, 792], width: 612, height: 792 do
      bounding_box [85, 792], width: 442, height: 792 do
        header
        profile_info
        invoice_items
        footer
      end
    end
  end

  def header
    move_down 40

    image  "#{Rails.root}/app/assets/images/invoice-logo.jpg", width: 450

    move_down 8
    text "<color rgb='a6a6a6'>Fakturanummer: #{@invoice.id.first(8)}</color>", inline_format: true
    move_down 10
    text "Datum: #{@invoice.updated_at.strftime('%F')}"
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
    text "Sverige"
  end

  def profile_info
    move_down 20

    data = [ ["Frilansare", "ID", "Jobb ID", "Startdag", "Sista dag", "ssyk-kod"],
     ["#{@invoice.profile_username}", "#{@invoice.profile_id}", "#{@invoice.job_id}", "#{@invoice.first_day}", "#{@invoice.last_day}", "#{@invoice.ssyk_code}"]]

    table(data, cell_style: { size: 10 }) do
     cells.padding = 6
     cells.borders = []
     row(0).font_style = :bold
    end
  end

  def invoice_items
    move_down 20
    @ex_moms = @invoice.amount * 0.8
    @moms = @invoice.amount * 0.2
    data = [ ["Beskrivning", "Kvantitet", "Enhet", "Summa"],
     [@invoice.description, @invoice.quantity, @invoice.unit, @invoice.amount.round],
     ["", "", "", "Att betala: #{@invoice.amount.round}.00"],
     ["", "", "", "Förfallodatum: #{@due_date.strftime('%F')}"],
     ["Exkl. moms #{@ex_moms.round}.00", "", "", "OCR: #{@invoice.ocr_number}"],
     ["Moms(25%) #{@moms.round}.00", "", "", "Bankgiro: 23929042932"]]

    table(data, cell_style: { size: 10 }) do
     cells.padding = 12
     cells.borders = []
     row(0).borders = [:bottom]
     row(0).border_width = 2
     row(0).font_style = :bold
     columns(0).width = 180
     columns(3).width = 100
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

    data = [ ["Adress", "Telefon", "Säte", "Momsreg.nr"],
     ["Göteborgs Villa och husmåleri Ab", "0707301078", "Göteborg", "SE559013369901"],
     ["Södra tandåsgatan 33", "0735304864", "Org.nr", ""],
     ["41267, Göteborg", "Epost", "5590133699"," "],
     ["", "gbghusmaleri@gmail.com", "Godkänd för F-skatt", ""]]

    table(data, cell_style: { size: 9 }) do
     cells.padding = 5
     cells.borders = []
     row(0).font_style = :bold
     row(2).columns(2).font_style = :bold
     row(3).columns(1).font_style = :bold
    end
  end
end

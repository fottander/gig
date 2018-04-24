class EzinvoicePdf < Prawn::Document
  def initialize(ezinvoice, profile, due_date)
    @ezinvoice = ezinvoice
    @profile = profile
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
        ezinvoice_items
        footer
      end
    end
  end

  def header
    move_down 40

    image  "#{Rails.root}/app/assets/images/anewbiz-logo-2.png", width: 194

    move_down 8
    text "<color rgb='a6a6a6'>Fakturanummer: #{@ezinvoice.id.first(8)}</color>", inline_format: true
    move_down 10
    text "Datum: #{@ezinvoice.updated_at.strftime('%F')}"
    text "Referens: #{@ezinvoice.user_reference}"
    text "Er referens: #{@ezinvoice.company_reference}"
    text "Org. nummer: #{@ezinvoice.org_number}"
    text "#{@ezinvoice.company_name}"
    text "#{@ezinvoice.company_address}"
    text "#{@ezinvoice.company_zip}, #{@ezinvoice.company_city}"
    text "Sverige"
  end

  def profile_info
    move_down 20

    data = [ ["Frilansare", "ID", "Startdag", "Sista dag", "ssyk-kod"],
     ["#{@ezinvoice.profile_username}", "#{@ezinvoice.profile_id}", "#{@ezinvoice.first_day}", "#{@ezinvoice.last_day}", "#{@ezinvoice.ssyk_code}"]]

    table(data, cell_style: { size: 10 }) do
     cells.padding = 5
     cells.borders = []
     row(0).font_style = :bold
    end
  end

  def ezinvoice_items
    move_down 20
    @moms = @ezinvoice.fakturabelopp_inklmoms * 0.2
    data = [ ["Beskrivning", "Antal timmar", "", "Timlön"],
     [@ezinvoice.description, @ezinvoice.quantity, "", @ezinvoice.unit],
     ["", "", "", "Förfallodatum: #{@due_date.strftime('%F')}"],
     ["", "", "", "OCR: #{@ezinvoice.ocr_number}"],
     ["", "", "", "Plusgiro: 86 40 62-5"],
     ["Exkl. moms #{@ezinvoice.fakturabelopp}.00", "Moms(25%) #{@moms.round}.00", "", "Att betala: #{@ezinvoice.fakturabelopp_inklmoms}.00"]]

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
     ["FeltCap AB", "0707301078", "Göteborg", "SE559129609901"],
     ["Storgatan 41, lgh 1101", "0735304864", "Org.nr", ""],
     ["41138, Göteborg", "Epost", "559129-6099"," "],
     ["", "info@anewbiz.se", "Godkänd för F-skatt", ""]]

    table(data, cell_style: { size: 9 }) do
     cells.padding = 5
     cells.borders = []
     row(0).font_style = :bold
     row(2).columns(2).font_style = :bold
     row(3).columns(1).font_style = :bold
    end
  end
end

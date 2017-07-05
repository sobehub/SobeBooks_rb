class PdfkitController < ApplicationController
  def new
  	invoice=Invoice.find(params[:id])
  	kit = PDFKit.new(render_to_string(:action => "invoices/show.html.erb"))
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/bootstrap.css"
    filename ||= "#{Rails.root}/public/receipts/#{invoice.id}.pdf"
    send_data kit.render, filename: 'invoice.pdf', type: 'application/pdf'

    render :layout => false
  end
end

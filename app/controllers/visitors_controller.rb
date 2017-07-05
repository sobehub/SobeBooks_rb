class VisitorsController < ApplicationController
	respond_to do |format|
    format.html
    format.pdf do
      send_data invoice.render_pdf, :filename => "Invoice #12.pdf", :type => "application/pdf", :disposition => "inline"
    end
  end
end

class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = current_user.invoices.order("id DESC")
  end

  def invoices_of_a_single_client
   client = Client.find(params[:client_id])
   @invoices = client.invoices.where(:status => 'unpaid')

   respond_to do |format|
     format.json { render  json:  @invoices, status: :ok }
   end
  end
  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @line_item = LineItem.new
    invoice = Invoice.find(params[:id])
    @lineitems_invoices = invoice.line_items
  end

  def summary_invoice
    result = Client.where(:id => params[:client_id])
    result = result.where(:status => params[:client_type]) if params[:client_type].present?

    if result.present?
      @invoices =  result.first.invoices.order("updated_at DESC")
      @invoices = @invoices.where("created_at > ?", params[:date_from].to_datetime) if params[:date_from]
      @invoices = @invoices.where("created_at < ?", params[:date_to].to_datetime) if params[:date_to]
    end

    respond_to do |format|
      format.json { render  json:  @invoices , status: :ok }
    end
  end
  

  def invoicesummary
  end

  def test
    result = Clienttransaction.where(:client_id=>params[:client_id])

    @invoices = Array.new
    if result.present?
      @invoices = result.where("created_at > ?", params[:date_from].to_datetime) if params[:date_from]
      @invoices = result.where("created_at < ?", params[:date_to].to_datetime) if params[:date_to]
      @invoices = result.first.transactioninvoices.order("updated_at DESC")
    end
  end

  def downloadinvoice
      # byebug
      @invoice = Invoice.find(params[:id].to_i)
      @line_item = LineItem.new
      @lineitems_invoices = @invoice.line_items

      kit = PDFKit.new(render_to_string(:action => "show.html.erb"))
      kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/bootstrap.css"

      file = kit.to_pdf
      email_id = params[:emailinvoice]
      Emailinvoicepdf.send_pdf_email_invoice(email_id,current_user,file,@invoice).deliver_now
      flash[:notice] = "Invoice has been email to your email account successfully."
      redirect_to :back
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    
    @invoice.user_id = current_user.id
    if @invoice.status == 'paid'
      amount = params[:amount]
      @invoice.totalpaid = @invoice.amount
    end
      
    respond_to do |format|
      if @invoice.save
        set_formatted_dates()
        rate = params[:rate]
        quantity = params[:quantity]
        desc = params[:desc]
        
        rate.zip(quantity,desc).each do |rat, quan, desc|
          @lineitem = LineItem.create(price: rat, quantity: quan, description: desc, invoices_id: @invoice.id)
          @lineitem.save
        end
        format.html { redirect_to invoices_path, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        set_formatted_dates()
        format.json { render json: @invoice.to_json(include: :client), status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_formatted_dates
      @invoice.update_attribute(:duedate, formatted_date(invoice_params[:duedate])) if invoice_params[:duedate].present?
      @invoice.update_attribute(:transaction_date, formatted_date(invoice_params[:transaction_date])) if invoice_params[:transaction_date].present?
    end

    def set_invoice
      @invoice  = current_user.invoices.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:reference,:amount,:balance,:notes,:lastpayment,
        :totalpaid,:client_id,:status,:duedate,:transaction_date)
    end
end

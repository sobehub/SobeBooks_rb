class ClienttransactionsController < ApplicationController
  before_action :set_clienttransaction, only: [:show, :edit, :update, :destroy]

  # GET /clienttransactions
  # GET /clienttransactions.json
  def index
    @clienttransactions = current_user.clienttransactions.order("id DESC")
  end

  # GET /clienttransactions/1
  # GET /clienttransactions/1.json
  def show
  end

  # GET /clienttransactions/new
  def new
    @clienttransaction = Clienttransaction.new
  end

  # GET /clienttransactions/1/edit
  def edit
    @client_transaction = Clienttransaction.find(params[:id])
    @edit_invoice = @client_transaction.invoices    
    @open_invoices = @client_transaction.client.invoices.where(:status => 'unpaid')
  end

  # POST /clienttransactions
  # POST /clienttransactions.json
  def create
    @clienttransaction = Clienttransaction.new(clienttransaction_params)
    @clienttransaction.user_id = current_user.id
    
    respond_to do |format|
      if @clienttransaction.save
        set_formatted_dates()

        ids = params[:invoices]
        ids= ids.split(","); # Split ids because it was
        balances = params[:balances]
        amount = params[:transaction_amount]
        refnum = params[:reference_no]
        cashtype = params[:Cash_type]
        amount.to_f
        ids.zip(balances).each do |id, balance|  #Each loop through two arrays
          @invoice= Invoice.find(id) # Find Invoice id to update balance in invoice table

          @value =  @invoice.totalpaid.to_f + balance.to_f
          Invoice.where(id: id).update_all(totalpaid: @value, balance: (@invoice.amount.to_f - @value.to_f)) # Update total paid against each Invoice id

          Transactioninvoice.create(:invoice_id => id, :clienttransaction_id => @clienttransaction.id,
                                    :balance => balance, :amount=> amount, :reference_no => refnum,
                                    :Cash_type => cashtype, :user_id => current_user.id)

          Invoice.where(id: id, amount: @value).update_all(status: 'paid') # If Invoice amount equals to last paid change status to paid
        end

        format.html { redirect_to clienttransactions_path, notice: 'Transaction was successfully processed.' }
        format.json { render :show, status: :created, location: @clienttransaction }
        format.js{}

      else
        format.html { render :new }
        format.json { render json: @clienttransaction.errors, status: :unprocessable_entity }
        format.js{}

      end
    end
  end

  # PATCH/PUT /clienttransactions/1
  # PATCH/PUT /clienttransactions/1.json
  def update
    respond_to do |format|
      if @clienttransaction.update(clienttransaction_params)
        set_formatted_dates()
        ids = params[:invoices]
        ids = ids.split(",")
        balances = params[:balances]
        amount= params[:transaction_amount]
        amount.to_f

        ids.zip(balances).each do |id, balance|  #Each loop through two arrays
          @invoice = Invoice.find(id)
          @value =  @invoice.totalpaid.to_f + balance.to_f
          Invoice.where(id: id).update_all(totalpaid: @value, balance: (@invoice.amount.to_f - @value.to_f))

          Transactioninvoice.create(invoice_id: id, clienttransaction_id: @clienttransaction.id,
                                    balance: balance, amount: amount)
          Invoice.where(id: id, amount: @value).update_all(status: 'paid')
        end
        format.html { redirect_to clienttransactions_path, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @clienttransaction }
      else
        format.html { render :edit }
        format.json { render json: @clienttransaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clienttransactions/1
  # DELETE /clienttransactions/1.json
  def destroy
    @clienttransaction.destroy
    respond_to do |format|
      format.html { redirect_to clienttransactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formatted_dates
      @clienttransaction.update_attribute(:duedate, formatted_date(clienttransaction_params[:duedate])) if clienttransaction_params[:duedate].present?
      @clienttransaction.update_attribute(:transaction_date, formatted_date(clienttransaction_params[:transaction_date])) if clienttransaction_params[:transaction_date].present?
    end

    def set_clienttransaction
      @clienttransaction = Clienttransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clienttransaction_params
      params.require(:clienttransaction).permit(:setup_id, :client_id,:user_id, :transaction_date, :duedate)
    end
end

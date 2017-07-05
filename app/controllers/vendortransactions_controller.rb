class VendortransactionsController < ApplicationController
  before_action :set_vendortransaction, only: [:show, :edit, :update, :destroy]

  # GET /vendortransactions
  # GET /vendortransactions.json
  def index
    @vendortransactions = current_user.vendortransactions.order("id DESC")
  end

  # GET /vendortransactions/1
  # GET /vendortransactions/1.json
  def show
  end

  # GET /vendortransactions/new
  def new
    @vendortransaction = Vendortransaction.new
  end

  # GET /vendortransactions/1/edit
  def edit
  end

  # POST /vendortransactions
  # POST /vendortransactions.json
  def create
    @vendortransaction = Vendortransaction.new(vendortransaction_params)
    @vendortransaction.user_id = current_user.id

    respond_to do |format|
      if @vendortransaction.save
        set_formatted_dates()
        ids = params[:invoices]
        ids = ids.split(",")
        balances = params[:balances]
        amount = params[:transaction_amount]
        refnum = params[:reference_no]
        cashtype = params[:Cash_type]
        amount.to_f

        ids.zip(balances).each do |id, balance|  #Each loop through two arrays
          @invoice= Bill.find(id)
          @value =  @invoice.totalpaid.to_f + balance.to_f

          Bill.where(:id => id).update_all(totalpaid: @value, balance: (@invoice.amount.to_f - @value.to_f))
          Transactionbill.create(:bill_id => id, :vendortransaction_id => @vendortransaction.id,
                                 :balance => balance, :amount => amount, :reference_no => refnum,
                                 :Cash_type => cashtype)
          Bill.where(:id => id, :amount => @value).update_all(:status => 'paid')
        end

        format.html { redirect_to vendortransactions_path, notice: 'Transaction was successfully processed.' }
        format.json { render :show, status: :created, location: @vendortransaction }
      else
        format.html { render :new }
        format.json { render json: @vendortransaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendortransactions/1
  # PATCH/PUT /vendortransactions/1.json
  def update
    respond_to do |format|
      if @vendortransaction.update(vendortransaction_params)
        set_formatted_dates()

        ids = params[:invoices]
        ids = ids.split(",")
        balances = params[:balances]
        amount = params[:transaction_amount]
        # refnum = params[:reference_no]
        # cashtype = params[:Cash_type]
        amount.to_f

        ids.zip(balances).each do |id, balance|  #Each loop through two arrays
          @invoice= Bill.find(id)
          @value =  @invoice.totalpaid.to_f + balance.to_f

          Bill.where(:id => id).update_all(totalpaid: @value, balance: (@invoice.amount.to_f - @value.to_f))
          Transactionbill.create(:bill_id => id, :vendortransaction_id => @vendortransaction.id,
                                 :balance => balance, :amount => amount)
          Bill.where(:id => id, :amount => @value).update_all(:status => 'paid')
        end
        format.html { redirect_to vendortransactions_path, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendortransaction }
      else
        format.html { render :edit }
        format.json { render json: @vendortransaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendortransactions/1
  # DELETE /vendortransactions/1.json
  def destroy
    @vendortransaction.destroy
    respond_to do |format|
      format.html { redirect_to vendortransactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formatted_dates
      @vendortransaction.update_attribute(:duedate, formatted_date(vendortransaction_params[:duedate])) if vendortransaction_params[:duedate].present?
      @vendortransaction.update_attribute(:transaction_date, formatted_date(vendortransaction_params[:transaction_date])) if vendortransaction_params[:transaction_date].present?
    end
    def set_vendortransaction
      @vendortransaction = Vendortransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendortransaction_params
      params.require(:vendortransaction).permit(:setup_id, :vendor_id, :user_id, :transaction_date, :duedate)
    end
end

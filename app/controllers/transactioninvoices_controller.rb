class TransactioninvoicesController < ApplicationController
  before_action :set_transactioninvoice, only: [:show, :edit, :update, :destroy]

  # GET /transactioninvoices
  # GET /transactioninvoices.json
  def index
    @transactioninvoices = Transactioninvoice.all
  end

  # GET /transactioninvoices/1
  # GET /transactioninvoices/1.json
  def show
  end

  # GET /transactioninvoices/new
  def new
    @transactioninvoice = Transactioninvoice.new
  end

  # GET /transactioninvoices/1/edit
  def edit
  end

  # POST /transactioninvoices
  # POST /transactioninvoices.json
  def create
    @transactioninvoice = Transactioninvoice.new(transactioninvoice_params)

    respond_to do |format|
      if @transactioninvoice.save
        format.html { redirect_to @transactioninvoice, notice: 'Transactioninvoice was successfully created.' }
        format.json { render :show, status: :created, location: @transactioninvoice }
      else
        format.html { render :new }
        format.json { render json: @transactioninvoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactioninvoices/1
  # PATCH/PUT /transactioninvoices/1.json
  def update
    respond_to do |format|
      if @transactioninvoice.update(transactioninvoice_params)
        format.html { redirect_to @transactioninvoice, notice: 'Transactioninvoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @transactioninvoice }
      else
        format.html { render :edit }
        format.json { render json: @transactioninvoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactioninvoices/1
  # DELETE /transactioninvoices/1.json
  def destroy
    @transactioninvoice.destroy
    respond_to do |format|
      format.html { redirect_to transactioninvoices_url, notice: 'Transactioninvoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transactioninvoice
      @transactioninvoice = Transactioninvoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transactioninvoice_params
      params.require(:transactioninvoice).permit(:clienttransaction_id, :invoice_id)
    end
end

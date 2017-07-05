class TransactionbillsController < ApplicationController
  before_action :set_transactionbill, only: [:show, :edit, :update, :destroy]

  # GET /transactionbills
  # GET /transactionbills.json
  def index
    @transactionbills = Transactionbill.all
  end

  # GET /transactionbills/1
  # GET /transactionbills/1.json
  def show
  end

  # GET /transactionbills/new
  def new
    @transactionbill = Transactionbill.new
  end

  # GET /transactionbills/1/edit
  def edit
  end

  # POST /transactionbills
  # POST /transactionbills.json
  def create
    @transactionbill = Transactionbill.new(transactionbill_params)

    respond_to do |format|
      if @transactionbill.save
        format.html { redirect_to @transactionbill, notice: 'Transactionbill was successfully created.' }
        format.json { render :show, status: :created, location: @transactionbill }
      else
        format.html { render :new }
        format.json { render json: @transactionbill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactionbills/1
  # PATCH/PUT /transactionbills/1.json
  def update
    respond_to do |format|
      if @transactionbill.update(transactionbill_params)
        format.html { redirect_to @transactionbill, notice: 'Transactionbill was successfully updated.' }
        format.json { render :show, status: :ok, location: @transactionbill }
      else
        format.html { render :edit }
        format.json { render json: @transactionbill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactionbills/1
  # DELETE /transactionbills/1.json
  def destroy
    @transactionbill.destroy
    respond_to do |format|
      format.html { redirect_to transactionbills_url, notice: 'Transactionbill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transactionbill
      @transactionbill = Transactionbill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transactionbill_params
      params.require(:transactionbill).permit(:bill_id, :vendortransaction_id, :amount, :balance)
    end
end

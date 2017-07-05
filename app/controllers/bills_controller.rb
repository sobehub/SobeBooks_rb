class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  # GET /bills
  # GET /bills.json
  def index
    @bills = current_user.bills.order("id DESC")
  end

  # GET /bills/1
  # GET /bills/1.json
  def bills_of_a_single_client
   vendor = Vendor.find(params[:vendor_id])
   @bills =  vendor.bills.where(:status=>'unpaid')

   respond_to do |format|
    format.json { render  json: @bills, status: :ok }
   end
  end

  def show
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(bill_params)
    @bill.user_id = current_user.id
    @bill.totalpaid = @bill.amount if @bill.status =='paid'

    respond_to do |format|
      if @bill.save
        set_formatted_dates()
        format.html { redirect_to bills_url, notice: 'Bill was successfully created.' }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        set_formatted_dates()
        format.json { render json: @bill.to_json(include: :vendor), status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to bills_url, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_formatted_dates
      @bill.update_attribute(:duedate, formatted_date(bill_params[:duedate])) if bill_params[:duedate].present?
      @bill.update_attribute(:transaction_date, formatted_date(bill_params[:transaction_date])) if bill_params[:transaction_date].present?
    end

    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:reference, :notes, :amount, :lastpaid, :totalpaid,
       :status, :vendor_id,:balance,:lastpayment, :duedate, :transaction_date, :setup_id)
    end
end

class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  # GET /vendors
  # GET /vendors.json
  def index
    @vendors = current_user.vendors.order_by_name
    @vendors = @vendors.search_results(params[:search]) if params[:search].present?
  end

  # GET /vendors/1
  # GET /vendors/1.json
  def show
    vendor = Vendor.find(params[:id])
    @unpaidvendor = vendor.bills.where(:status => 'unpaid')
  end

  # GET /vendors/new
  def new
    @vendor = Vendor.new
  end

  # GET /vendors/1/edit
  def edit
  end

  def summary_vendor
  result = Vendor.where(:id => params[:vendor_id])
  result = result.where(:status => params[:vendor_type]) if params[:vendor_type].present?

  if result.present?
    @bills = result.first.bills.order("updated_at DESC")
    @bills = @bills.where("created_at > ?", params[:date_from].to_datetime) if params[:date_from]
    @bills = @bills.where("created_at > ?", params[:date_to].to_datetime) if params[:date_to]
  end

  respond_to do |format|
    format.json { render  json:  @bills , status: :ok }
  end  
end

  def vendorsummary

  end  
  # POST /vendors
  # POST /vendors.json
  def create
    @vendor = Vendor.new(vendor_params)
    @vendor.user_id = current_user.id

    respond_to do |format|
      if @vendor.save
        format.html { redirect_to vendors_path, notice: 'Vendor was successfully created.' }
        format.json { render :show, status: :created, location: @vendor }
      else
        format.html { render :new }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendors/1
  # PATCH/PUT /vendors/1.json
  def update
    respond_to do |format|
      if @vendor.update(vendor_params)
        format.html { redirect_to vendors_path, notice: 'Vendor was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor }
      else
        format.html { render :edit }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendors/1
  # DELETE /vendors/1.json
  def destroy
    @vendor.destroy
    respond_to do |format|
      format.html { redirect_to vendors_url, notice: 'Vendor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      @vendor = current_user.vendors.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_params
      params.require(:vendor).permit(:name, :company_name, :email, :phone, :identifier, 
        :reference, :notes,:status,:setup_id)
    end
end

class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
    @invoice = Invoice.find(params[:invoice_id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @line_item = LineItem.new(line_item_params)
    @line_item.invoices_id = params[:invoice_id]
    @invoice = Invoice.find(params[:invoice_id])

    respond_to do |format|
      if @line_item.save
        format.json { render json: @line_item, status: :ok }
      else
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        invoice = @line_item.invoice
        new_sum = invoice.line_items.collect{ |l| (l.price * l.quantity) }.sum.to_f
        invoice.amount = new_sum
        invoice.save
        format.json { render json: @line_item, status: :ok }
      else
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    invoice = @line_item.invoice

    if @line_item.destroy
      new_sum = invoice.line_items.collect{|l| (l.price * l.quantity)}.sum.to_f
      invoice.amount = new_sum
      invoice.save
      respond_to do |format|
        format.json { render json: @line_item, status: :ok }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item= LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:price, :description, :quantity, :invoice_update_amount)
    end
end

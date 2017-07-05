class ReportsController < ApplicationController

  def customersummary
    conditions = ''
    if params[:client_id].present?
      conditions = "client_id = #{params[:client_id].to_i}"
    end
    if params[:date_from].present? and params[:date_to].present?
      temp = "created_at >= '#{formatted_date(params[:date_from]).to_date}' AND DATE(created_at) <= '#{formatted_date(params[:date_to]).to_date}'"
      conditions = conditions.blank? ? temp : "#{conditions} AND #{temp}"
    end

    @invoices = conditions.blank? ? Clienttransaction.all.order("updated_at DESC") :
        Clienttransaction.where(conditions).order("updated_at DESC")
  end

  def vendorsummary
    conditions = ''
    if params[:vendor_id].present?
      conditions = "vendor_id = #{params[:vendor_id].to_i}"
    end

    if params[:date_from].present? and params[:date_to].present?
      temp = "created_at >= '#{formatted_date(params[:date_from]).to_date}' AND DATE(created_at) <= '#{formatted_date(params[:date_to]).to_date}'"
      conditions = conditions.blank? ? temp : "#{conditions} AND #{temp}"
    end

    @bills = conditions.blank? ? Vendortransaction.all.order("updated_at DESC") :
        Vendortransaction.where(conditions).order("updated_at DESC")
  end

  def clientdetail
    if params[:client_id].present?
      @invoices = Clienttransaction.where(:client_id => params[:client_id]).order("updated_at DESC")
    else
      @invoices = Clienttransaction.order("updated_at DESC")
    end

    if @invoices.present? && params[:date_from].present? && params[:date_to].present?
      @invoices = @invoices.where("created_at >= ?", formatted_date(params[:date_from]).to_date)
      @invoices = @invoices.where("DATE(created_at) <= ?", formatted_date(params[:date_to]).to_date)
    end
  end

  def vendordetail
    if params[:vendor_id].present?
      @bills = Vendortransaction.where(:vendor_id => params[:vendor_id]).order("updated_at DESC")
    else
      @bills = Vendortransaction.order("updated_at DESC")
    end


    if @bills.present? && params[:date_from].present? && params[:date_to].present?
      @bills = @bills.where("created_at >= ?", formatted_date(params[:date_from]).to_date)
      @bills = @bills.where("DATE(created_at) <= ?", formatted_date(params[:date_to]).to_date)
    end
  end

  def transactionhistory
    if params[:date_from].present?
      user_invoice_ids = current_user.invoices.map(&:id)

      @begining_balance_inv = Transactioninvoice.where(invoice_id: user_invoice_ids)
                                  .where("created_at < ? ", params[:date_from].to_datetime)
                                  .map{|t| t.balance}.compact.sum.to_f

      user_bill_ids = current_user.bills.map(&:id)
      @begining_balance_bill = Transactionbill.where(bill_id: user_bill_ids)
                                   .where("created_at < ? ", params[:date_from].to_datetime)
                                   .map{|t| t.balance}.compact.sum.to_f

      @begining_balance = @begining_balance_inv - @begining_balance_bill
    end

    @history = Array.new
    if params[:client_id].present?
      conditions = "vendor_id IN (#{params[:vendor_id].join(', ')})"
      if params[:date_from].present? and params[:date_to].present?
        conditions += " AND created_at >= '#{params[:date_from].to_datetime}' AND DATE(created_at) <= '#{params[:date_to].to_datetime}'"
      end

      @history << Vendortransaction.where(conditions).order("updated_at DESC")

      conditions = "client_id IN (#{params[:client_id].join(', ')})"
      if params[:date_from].present? and params[:date_to].present?
        conditions += " AND created_at >= '#{params[:date_from].to_datetime}' AND DATE(created_at) <= '#{params[:date_to].to_datetime}'"
      end

      @history << Clienttransaction.where(conditions).order("updated_at DESC")

      @data = @history.flatten.sort_by{ |x| x.updated_at }
    end
  end

  def bankbalance
    if params[:date_from].present?
      bank_id_for_client = Clienttransaction.where(setup_id: params[:bank_id]).
          where("created_at < ? ", params[:date_from].to_datetime).map(&:id)

      @client_bal = Transactioninvoice.where(clienttransaction_id:bank_id_for_client).
          map{|s| s.balance}.compact.sum.to_f

      bank_id_for_vendor = Vendortransaction.where(setup_id: params[:bank_id])
                               .where("created_at < ? ", formatted_date(params[:date_from]).to_date).map(&:id)

      @vendor_blc = Transactionbill.where(vendortransaction_id: bank_id_for_vendor)
                        .map{|t| t.balance}.compact.sum.to_f

      @begining_balance = @client_bal - @vendor_blc
    end

    @banks = Array.new

    if params[:bank_id].present?
      conditions = "setup_id = #{params[:bank_id].to_i}"
      if params[:date_from].present? and params[:date_to].present?
        conditions += " AND created_at >= '#{formatted_date(params[:date_from]).to_date}' AND DATE(created_at) <= '#{formatted_date(params[:date_to]).to_date}'"
      end

      @banks << Vendortransaction.where(conditions).order("updated_at DESC")
      @banks << Clienttransaction.where(conditions).order("updated_at DESC")

      @data = @banks.flatten.sort_by{ |x| x.updated_at.to_date }
    end
  end

  def summary_vendor
    result = Vendor.where(:id => params[:vendor_id])
    result = result.where(:status => params[:vendor_type]) if params[:vendor_type].present?
    if result.present?
      @bills =  result.first.bills.order("updated_at DESC")
      @bills = @bills.where("created_at > ?", params[:date_from].to_datetime) if params[:date_from]
      @bills = @bills.where("created_at < ?", params[:date_to].to_datetime) if params[:date_to]
    end

    respond_to do |format|
      format.json { render  json:  @bills , status: :ok }
    end
  end

  def paymentdetail
    if params[:date_from].present?
      user_bill_ids = current_user.bills.map(&:id)
      @begining_balance = Transactionbill.where(bill_id: user_bill_ids)
                              .where("created_at < ? ", formatted_date(params[:date_from]).to_date)
                              .map{|t| t.balance}.compact.sum.to_f
    end

    if params[:vendor_id].present?
      conditions = "vendor_id IN (#{params[:vendor_id].join(', ')})"
      if params[:date_from].present? and params[:date_to].present?
        conditions += " AND created_at >= '#{formatted_date(params[:date_from]).to_date}' AND DATE(created_at) <= '#{formatted_date(params[:date_to]).to_date}'"
      end
      @payment = Vendortransaction.where(conditions)

      @data = @payment.flatten.sort_by{ |x| x.updated_at.to_date }
    end
  end

  def cashdetail
    if params[:date_from].present?
      user_invoice_ids = current_user.invoices.map(&:id)

      @begining_balance = Transactioninvoice.where(invoice_id: user_invoice_ids)
                              .where("created_at < ? ", formatted_date(params[:date_from]).to_date)
                              .map{|t| t.balance}.compact.sum.to_f
    end

    if params[:client_id].present?
      conditions = "client_id IN (#{params[:client_id].join(', ')})"
      if params[:date_from].present? and params[:date_to].present?
        conditions += " AND created_at >= '#{formatted_date(params[:date_from]).to_date}' AND DATE(created_at) <= '#{formatted_date(params[:date_to]).to_date}'"
      end

      @cash =  Clienttransaction.where(conditions).order("updated_at DESC")
      @data = @cash.flatten.sort_by{ |x| x.updated_at.to_date }
    end
  end

  def paymentsummary
    if params[:vendor_id].present?
      vendor_id = Vendortransaction.where(:vendor_id=>params[:vendor_id]).
          where("created_at <?", params[:date_from].to_datetime).map(&:id)

      @begining_balance = Transactionbill.where(vendortransaction_id: vendor_id).map{|p| p.balance}.compact.sum.to_f
    end

    if params[:vendor_id].present?
      @data = Vendortransaction.where(:vendor_id=>params[:vendor_id]).order("updated_at DESC")
                  .where("created_at >= ? AND DATE(created_at) <= ?",
                         params[:date_from].to_datetime,params[:date_to].to_datetime)
    end
  end

  def cashsummary
  end
end

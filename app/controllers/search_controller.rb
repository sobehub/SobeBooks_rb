class SearchController < ApplicationController
  skip_before_filter :authenticate_user!, only: :landing

  def index
    @clients_count = current_user.clients.count
    @invoices_count = current_user.invoices.count
    @vendors_count = current_user.vendors.count
    @bills_count = current_user.bills.count
    @banks_count = current_user.setups.where(setuptype: 'bank').count
  end

  def results
    @search = params[:q]
    @invoices = current_user.invoices.search_invoices(@search)
    @clients = current_user.clients.search_clients(@search)
    @vendors = current_user.vendors.search_vendors(@search)
    @bills = current_user.bills.search_bills(@search)
  end

  def landing
    render layout: 'splash'
  end
end

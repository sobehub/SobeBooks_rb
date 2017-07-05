Rails.application.routes.draw do

  get '/reports/clientdetail'=>'reports#clientdetail'
  get '/reports/transactionhistory'=>'reports#transactionhistory'
  get '/reports/vendordetail'=>'reports#vendordetail'
  get '/reports/downloadinvoice/:id'=>'invoices#downloadinvoice'
  get '/reports/customersummary'=>'reports#customersummary'
  get '/reports/vendorsummary'=> "reports#vendorsummary"
  get '/reports/bankbalance'=> "reports#bankbalance"
  get '/reports/paymentdetail'=> "reports#paymentdetail"
  get '/reports/cashdetail'=> "reports#cashdetail"
  get '/reports/paymentsummary'=> "reports#paymentsummary"
  get '/reports/cashsummary'=> "reports#cashsummary"

  get '/invoices/downloadinvoice/:id'=>'invoices#downloadinvoice'
  get '/invoices/summary_invoice/:client_id/'=>'invoices#summary_invoice'
  get '/invoices/summary_invoice/:client_id/:client_type/'=>'invoices#summary_invoice'
  get '/invoices/summary_invoice/:client_id/:client_type/:date_from/'=>'invoices#summary_invoice'
  get '/invoices/summary_invoice/:client_id/:client_type/:date_from/:date_to'=>'invoices#summary_invoice'
  get '/invoices/invoicesummary'=>'invoices#invoicesummary'

  get 'public/privacy'

  get 'public/conditions'

  resources :transactionbills
  resources :vendortransactions
  resources :transactioninvoices
  resources :clienttransactions
  resources :setups
  resources :setups
  resources :bills
  resources :invoices do
    resources :line_items
  end

  resources :vendors
  resources :clients
  get 'history/index'
  get 'search/index'
  get 'landing' => 'search#landing'

  get 'users/send_email'
  get 'users/notes', as: "get__user_notes"
  post 'users/notes', as: "user_notes"
  get 'users/setup'
  get 'search/results'

  get "/user/:id" => "users#user_profile", :as=> "user_profile"
  get '/invoices/invoices_of_a_single_client/:client_id' => 'invoices#invoices_of_a_single_client'
  
  get '/bills/bills_of_a_single_client/:vendor_id' => 'bills#bills_of_a_single_client'
  
  root to: 'search#index'
  devise_for :users
  resources :users
end

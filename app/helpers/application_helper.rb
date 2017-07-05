module ApplicationHelper
  def visibility_status_list
    [['Active', 'active'], ['Inactive', 'inactive'], ['Past due', 'past due']]
  end

  def invoice_status_list
    [['Unpaid','unpaid'], ['Draft', 'draft']]
  end

  def display_formatted_date(date)
    date.strftime('%m-%d-%Y') rescue ''
  end
end

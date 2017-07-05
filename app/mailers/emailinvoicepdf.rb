class Emailinvoicepdf < ApplicationMailer
   def send_pdf_email_invoice(email_id,user,file,invoice)
	@to= email_id
	@user=user
	attachments["Invoice##{invoice.id}.pdf"] = file
	mail(to: @to, subject: "Invoice by #{@user.name}")
end

 end
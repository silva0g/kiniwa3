class ReservationMailer < ApplicationMailer
	def send_email_to_client(client, menu)
		@recipient = client
		@menu = menu
		mail(to: @recipient.email, subject: "Bon dégustation")
	end
end 
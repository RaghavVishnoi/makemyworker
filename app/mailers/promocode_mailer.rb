class PromocodeMailer < ApplicationMailer
	default :from => 'info@pinchapp.com'

	def send_promocode(user,code,expiry_date)
		@user = user
		@code = code
		@expiry_date = expiry_date
		mail(to: 'raghavvishnoi10@gmail.com',subject:'Promo Code')
	end
end

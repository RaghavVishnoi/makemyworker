class StripeRecipient

	def self.generate(token,first_name,last_name)
		begin
			name = first_name.to_s+" "+last_name.to_s
			recipient = Stripe::Recipient.create(:name => name,:type => TYPE,:bank_account => token)
			recipient.id
		rescue => ex
			puts ex.message
		end	
	end

	def self.retrieve(token)
		recipient = Stripe::Recipient.retrieve(token)
		recipient['active_account'] 
	end

end
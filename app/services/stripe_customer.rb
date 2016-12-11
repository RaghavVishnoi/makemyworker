class StripeCustomer

	def self.generate(email,token)
		customer = Stripe::Customer.create(
		  card: token,
		  description: 'PINCH',
		  email: email
		)
		customer.id
	end

	def self.retrieve(token)
		customer = Stripe::Customer.retrieve(token)
		sources = customer[:sources]
		sources[:data]
	end

end
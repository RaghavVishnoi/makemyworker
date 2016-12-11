class Account

	def self.accounts(user_id)
		account = {}
		account[:card_detail] = card_details(user_id)
		account[:account_detail] = account_details(user_id)
		account
	end

	def self.card_details(user_id)
		card_detail = {}
		account = BuyerAccount.find_by(user_id: user_id)
		if account != nil
		  StripeCustomer.retrieve(account.customer_id)
		else
		  nil
		end		
	end


	def self.account_details(user_id)
		account_detail = {}
		account = SellerAccount.find_by(user_id: user_id)
		if account != nil
			StripeRecipient.retrieve(account.recipient_id)	
		else
		  nil
		end		
	end

end
class Withdraws

	def self.transfer(user_id,amount)
		@amount = amount.to_i*100
		credits = Credit.find_by(user_id: user_id)
		account = SellerAccount.find_by(user_id: user_id)
		if account != nil 
			if credits != nil
				available_amount = credits.counts
				if amount.to_i <= available_amount.to_i && available_amount.to_i != 0
					begin
						transfer = Stripe::Transfer.create(:amount => @amount,:currency => CURRENCY,:recipient => get_recipient(user_id),:description => DESCRIPTION)
						if transfer != nil
							Withdraw.create!(user_id: user_id,amount: amount,seller_account_id: account.id)
							seller_credits(user_id,amount)
						end
					rescue Exception => e
						puts e.message
						0
					end
				else
					2
				end	
			else
			 2
			end	
		else
		 0
		end	
	end

	def self.seller_credits(user_id,amount)
		credits = Credit.find_by(user_id: user_id)
		counts = credits.counts.to_i-amount.to_i
		credits.counts = counts
		credits.save!
    end

	def self.get_recipient(user_id)
		@account = SellerAccount.find_by(user_id: user_id)
		if @account != nil
			@account.recipient_id
		else
			0
		end
	end

end

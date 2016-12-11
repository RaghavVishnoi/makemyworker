class Charges

  	def self.transaction(request)
      begin 
        if request.status == 4
            amount = 5
            @amount = apply_promo_code(amount,request.buyer_id,request.seller_id).to_i
        elsif request.status == 7
            amount = gig_amount(request.gig_id).to_i
            @amount = apply_promo_code(amount,request.buyer_id,request.seller_id).to_i
        else
            @amount = 0
        end
          @charge = Stripe::Charge.create(:customer => get_customer(request),:amount => @amount*100,:description => DESCRIPTION,:currency  => CURRENCY)
          if @charge != nil
            seller_credits(gig_amount(request.gig_id).to_f,request.seller_id)
            record_charges(request.id,@charge[:amount]/100,request.buyer_id)
          end
      rescue => e
        e.message
      end
    end

    def self.get_customer(request)
      @buyer_id = request.buyer_id
      @account = BuyerAccount.find_by(user_id: @buyer_id)
      if @account != nil
        @account.customer_id
      else
        0
      end
    end
      

    def self.gig_amount(id)
   		Gig.find(id).price
    end

    def self.user_email(gig_id)
   	   gig = Gig.find(gig_id)
   	   User.find(gig.user_id).email
    end

    def self.seller_credits(amount,user_id)
      counts = amount.to_f - (amount.to_f*CREDITS.to_f)/100
      if Credit.exists?(user_id: user_id)
        credit = Credit.find_by(user_id: user_id)
        counts = counts+credit.counts.to_f
        Credit.where(user_id: user_id).update_all(counts: counts)
      else
        Credit.create(counts: counts,user_id: user_id)
      end
    end

    def self.record_charges(request_id,amount,user_id)
      account_id = BuyerAccount.find_by(user_id: user_id).id
      charge = Charge.new(request_id: request_id,user_id: user_id,buyer_account_id: account_id,amount: amount,status: 'Active')
      charge.save
    end

    def self.apply_promo_code(amount,user_id,seller_id)
      @my_promo_code = MyPromoCode.find_by(user_id: user_id,status: 0)
      if @my_promo_code != nil
            @promo_code = @my_promo_code.promo_code
            amount = amount_after_promo_code(amount,@promo_code)
            PromoCode.where(id: @my_promo_code.promo_code_id).update_all(status: 1)            
            @my_promo_code.update(status: 1)
            if @my_promo_code.is_referral_code == true
              puts "hhhhhhhhhhhhhh"
              if Credit.exists?(user_id: seller_id)
                credit = Credit.find_by(user_id: seller_id)
                counts = REFFERAL_AMOUNT.to_f+credit.counts.to_f
                Credit.where(user_id: seller_id).update_all(counts: counts)
                puts "iiiiiiiiiiii"
              else
                Credit.create(counts: REFFERAL_AMOUNT.to_f,user_id: seller_id)
                puts "jjjjjjjjjjjjjjj"
              end
            end
            amount
      else
        amount
      end
    end

    def self.amount_after_promo_code(amount,promo_code)
      if promo_code.amount_type == 0
         @amount = amount.to_f-((promo_code.amount.to_f*amount.to_f)/100)
      elsif promo_code.amount_type == 1
        @amount = amount.to_f - promo_code.amount.to_f
      else
         @amount = amount
      end
      @amount
    end


end
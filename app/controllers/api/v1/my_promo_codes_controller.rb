class Api::V1::MyPromoCodesController < Api::V1::ApisController

	def index
		@my_promo_code = MyPromoCode.find_by(user_id: User.get_user(token).id,status: 0)
		render :json => {:result => true,:object => @my_promo_code}
	end


	def create
		@user = User.get_user(token)	
		@code = my_promo_code_params[:code]		
		@promo_code = find_promo_code(@user.id,@code)
		if @promo_code != nil
			@my_promo_code = MyPromoCode.new(my_promo_code_params.
												merge(promo_code_id: @promo_code.id).
												merge(user_id: @user.id)
												)
			if if_code_open(@user.id)
				render :json => {:errors => t('my_promo_codes.exist')}
			else
				if if_code_expire(@promo_code.code) != nil
					render :json => {:errors => t('my_promo_codes.expire')}
				else
					if @my_promo_code.save
						render :json => {:result => true,:message => t('my_promo_codes.success')}
					else
						render_errors @my_promo_code.errors.full_messages
					end
				end	
			end	
		elsif is_referral_code(@code)
			if UsedReferralCode.exists?(user_id: @user.id)
				render :json => {:errors => t('referral_code.exist')}
			else
				if if_own_code(@code)
					render :json => {:errors => t('referral_code.invalid')}
				else
					@promo_code = PromoCode.new(code: @code,amount: 5,user_id: @user.id,amount_type: 1,all_users: false)
					if @promo_code.save
						@my_promo_code = MyPromoCode.new(my_promo_code_params.
													merge(promo_code_id: @promo_code.id).
													merge(user_id: @user.id).
													merge(is_referral_code: true)
													)
						if @my_promo_code.save
							use_referral_code(@code)
							render :json => {:result => true,:message => t('referral_code.success')}							
						else
							render_errors @my_promo_code.errors.full_messages
						end
					else
						render_errors @promo_code.errors.full_messages
					end
				end	
			end	
		else
			render :json => {:errors => t('my_promo_codes.wrong')}
		end				
	end


	def my_promo_code_params
		params.require(:my_promo_code).permit(:code)
	end

	def find_promo_code(user_id,promo_code)
		@promo_code = PromoCode.find_by('user_id = ? AND lower(code) = ? AND status = 0',user_id,promo_code.downcase)
		if @promo_code == nil
			@promo_code = PromoCode.find_by('lower(code) = ? AND all_users = ?',promo_code.downcase,true)
		end
		@promo_code
	end

	def if_code_open(user_id)
		MyPromoCode.exists?(user_id: user_id,status: 0)
	end

	def if_code_expire(code)
		PromoCode.find_by('lower(code) = ? AND expire_on <= ?',code.downcase,Date.today)
	end

	def is_referral_code(referral_code)
		code = ReferralCode.find_by('lower(code) = ?',referral_code)
		if code != nil
			true
		else
			false
		end
	end

	def referral_code(referral_code)
		ReferralCode.find_by('lower(code) = ?',referral_code.downcase)
	end

	def use_referral_code(referral_code)
		referral_code = ReferralCode.find_by('lower(code) = ?',referral_code.downcase)
		UsedReferralCode.create(referral_code_id: referral_code.id,user_id: User.get_user(token).id)
	end

	def if_own_code(referral_code)
		code = ReferralCode.find_by('lower(code) = ? AND user_id = ?',referral_code.downcase,User.get_user(token).id)
		if code != nil
			true
		else
			false
		end
	end

	def referral_code_amount_transfer(referral_code)
		user_id = ReferralCode.find_by('lower(code) = ?',referral_code.downcase).user_id
		if Credit.exists?(user_id: user_id)
			credit = Credit.find_by(user_id: user_id)
			counts = credit.counts.to_f + 5
			credit.update(counts: counts)
			1
		else
			counts = 5.0
			Credit.create!(counts: counts,user_id: user_id)
			1
		end
	end	

end	
class Api::V1::StripeController < Api::V1::ApisController
  skip_before_action :authenticate, only: [:create]

  def create
  	begin
      request_id = params[:stripe][:request_id]
      charge = Charges.transaction(params[:stripe][:token],request_id)
      if charge != nil
        user_id = Request.find(request_id).seller_id
        credits = seller_credits(charge[:amount]/100,user_id)
        if credits == true
          record_charges(request_id,charge[:amount]/100,user_id)
        end
      end
      render :json => {:result => true,:message => "You have successfully charge $#{charge[:amount]/100}"}
  	rescue Stripe::CardError => e
  		render :json => {:result => false,:message => e.message}
  	end
  end

  def transfer
  	begin
  		transfer = Withdraws.transfer(params[:stripe][:token],params[:stripe][:amount])
  		render :json => {:result => transfer}
  	rescue StripeException
  		render :json => {:result => StripeException.message}
  	end
  end

  


end  
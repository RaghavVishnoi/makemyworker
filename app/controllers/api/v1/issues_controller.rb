class Api::V1::IssuesController < Api::V1::ApisController

	def create
		@issue = Issue.new(issue_params.
				merge(request_id: params[:id]).
				merge(sender_id: find_sender)
			)
		if @issue.save
			render :json => {:result => true,:object => @issue}
		else
			render_errors @issue.errors.full_messages
		end
	end

	def issue_params
		params.require(:issue).permit(:description)
	end

	def find_sender
		User.get_user(token).id
	end

end
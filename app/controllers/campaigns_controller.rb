class CampaignsController < ApplicationController
	def new
  	@campaign = current_user.campaigns.build(params[:campaign])
 
  	@type = find_type

  	if @type == nil
  		redirect_to root_url
  	else
  		@campaign.type = @type

	  	add_conversation
	  	puts @campaign.conversation_starters.count

	  	set_authentication
	  	puts @campaign.authentication.provider
	  end
	end

	def create
		@campaign = Campaign.new campaign_params
		if @campaign.save 
			redirect_to root_url
		else
			flash[:notice] = "Errors present: " + @campaign.errors.full_messages.to_s
			find_type
		end
	end

	def edit
		@campaign = Campaign.find(params[:id])
		@campaign.conversation_starters.build
	end

	def udpate
		@campaign = Campaign.find(params[:id])
	end

	def search
		tweets = TwitterCampaign.search(params[:string], params[:count])
		render json: tweets.map { |tweet| tweet = tweet.text }
	end

	private

		def campaign_params
      params.require(:campaign).permit(:title, :type, :search_string, :start_date, :end_date, 
      	:is_active, :spams_per_day, :should_auto_activate, :authentication_id, :user_id,
      	:conversation_starters_attributes => [:text, :type])
    end

    def find_type
	    @type = params[:type]
	  	@type = current_authentication request if @type == nil
	  	return if @type == nil
	  	return @type
	  end

	  def add_conversation
	  	type = @type.gsub "Campaign", "Conversation"
	  	@campaign.conversation_starters.build(type: type)
	  end

	  def set_authentication
	  	puts "HERE"
	  	type = @type.gsub "Campaign", "Authentication"
	  	@campaign.authentication = current_user.authentications.select { |auth| auth.provider == type }.first
    end 
end

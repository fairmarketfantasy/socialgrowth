class CampaignsController < ApplicationController
	before_action :find_campaign, only: [:new, :edit, :update]
	before_action :create_campaign, only: [:create]
	before_action :find_type, only: [:new]
	before_action :build_a_conversation, only: [:new]

	def new
  	if @type == nil
  		redirect_to root_url
  	else
  		@campaign.type = @type

	  	set_authentication
	  	puts @campaign.authentication.provider
	  end
	end

	def create
		if @campaign.save 
			redirect_to root_url
		else
			flash[:notice] = "Errors present: " + @campaign.errors.full_messages.to_s
			find_type
			build_a_conversation
		end
	end

	def edit
		puts 'DX1123 YES'
		puts campaign_params if params[:campaign]
	end

	def index
	end

	def update
		@campaign = Campaign.find params[:id]
		
		respond_to do |format|
      if @campaign.update campaign_params 
        format.html { redirect_to root_url, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
	end

	def search
		tweets = TwitterCampaign.search(params[:string], params[:count])
		puts tweets.count
		puts "DX678"
		if tweets.count > 0
			render json: tweets.map { |tweet| tweet = tweet.text } 
		else
			puts "blah blah blah"	
			render json: "\"Could not find any tweets matching criteria\""
		end
	end

	private

		def campaign_params
      params.require(:campaign).permit(:id, :title, :type, :search_string, :start_date, :end_date, 
      	:is_active, :spams_per_day, :should_auto_activate, :authentication_id, :user_id,
      	 conversation_starters_attributes: [:id, :text, :type])
    end

    def find_campaign
  		@campaign = Campaign.find params[:id] if params[:id]
  		puts @campaign
  		puts "WILGF"
  		return @campaign if @campaign
  		@campaign = current_user.campaigns.build(params[:campaign])
    end

    def create_campaign
    	puts "create campaign #{campaign_params}"
    	@campaign = Campaign.new campaign_params
    	puts "DOSTCMP #{@campaign}"
    end

    def find_type
    	@type = @campaign.type ? @campaign.type : params[:type]
	    return get_type_from_campaign(@type) if @type
	    get_type_from_authentication
	  end

	  def get_type_from_authentication
	  	@type = current_authentication request #TwitterAuthentication
	  	return @type.gsub! "Authentication", "Conversation" if @type
	  end

	  def get_type_from_campaign(type)
	    @type.gsub! "Campaign", "Conversation"
	  end

	  def add_conversation
	  	@campaign.conversation_starters.build(type: @type)
	  end

	  def build_a_conversation
	  	puts "DX443 #{@type}"
	  	return if @campaign == nil
	  	add_conversation if @campaign.conversation_starters.count < 1
	  end

	  def set_authentication
	  	type = @type.gsub "Conversation", "Authentication"
	  	@campaign.authentication = current_user.authentications.select { |auth| auth.provider == type }.first
	  	@campaign.type = @type.gsub "Conversation", "Campaign"
    end 
end

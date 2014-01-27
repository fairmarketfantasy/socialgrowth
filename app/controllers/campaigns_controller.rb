class CampaignsController < ApplicationController
	include ApplicationHelper

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
			@campaign.type = @type.gsub "Conversation", "Campaign"
		end
	end

	def edit
	end

	def index
	end

	def pane
		@campaign = Campaign.find(params[:id])
	end

	def toggle
		campaign = Campaign.find(params[:id])
		campaign.is_active = !campaign.is_active
		if campaign.save
			render json: true
		else
			render json: false
		end
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
		if tweets && tweets.count > 0
			puts "Y2K45"
			puts tweets.first.to_s
			render json: tweets.map { |tweet| tweet = display_hash(tweet) }
		else
			render json: false
		end
	end

	private

		def campaign_params
      params.require(:campaign).permit(:id, :title, :type, :search_string, :start_date, :end_date, 
      	:is_active, :spams_per_day, :should_auto_activate, :authentication_id, :user_id,
      	 conversation_starters_attributes: [:id, :text, :type])
    end

    def find_campaign
  		@campaign = Campaign.find(params[:id]) if params[:id]
  		return if @campaign
  		@campaign = current_user.campaigns.build(params[:campaign])
    end

    def create_campaign
    	@campaign = Campaign.new campaign_params
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
	  	puts "c34 #{@campaign.type}"
	  end

	  def build_a_conversation
	  	return if @campaign == nil
	  	add_conversation unless @campaign.conversation_starters.count > 0
	  end

	  def set_authentication
	  	type = @type.gsub "Conversation", "Authentication"
	  	@campaign.authentication = current_user.authentications.select { |auth| auth.provider == type }.first
	  	@campaign.type = @type.gsub "Conversation", "Campaign"
    end 
end

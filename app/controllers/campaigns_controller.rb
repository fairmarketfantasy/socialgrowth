class CampaignsController < ApplicationController

	def new
		@campaign = Campaign.new params[:campaign]
	end

	def create
		@campaign = Campaign.new campaign_params
	end

	def edit
		@campaign = Campaign.find(params[:id])
	end

	def udpate
		@campaign = Campaign.find(params[:id])
	end

	private

	def campaign_params
      params.require(:campaign).permit(:start_date, :end_date, :is_active, :spams_per_day, :should_auto_activate, :tweets_sent_count)
    end
end

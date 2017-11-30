class DashboardsController < ApplicationController

	before_action :authenticate_user!
	def index
		@menus = current_user.menus
	end 
end
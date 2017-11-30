class SettingsController < ApplicationController

	def edit
		@setting = User.find(current_user.id).setting
	end 

	def update
		@setting = User.find(current_user.id).setting
		if @setting.update(setting_params)
			flash[:notice] = "Enregistré..."
		else
			flash[:alert] = "Impossible d'enregistré vos options.."
		end

		render 'edit'
	end 

	private
		def setting_params
			params.require(:setting).permit(:enable_sms, :enable_email)
		end
end
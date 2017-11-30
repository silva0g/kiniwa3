class CalendarsController < ApplicationController
	before_action :authenticate_user!

	include ApplicationHelper

	def create
		date_from = Date.parse(calendar_params[:start_date])
		date_to = Date.parse(calendar_params[:end_date])

		(date_from..date_to).each do |date|
			calendar = Calendar.where(menu_id: params[:menu_id], day: date)

			# Verification:
			# S'il existe une calendar dans la base de données
			if calendar.present? 
				# S'il existe une calendar dans la base de données on execute cette code snippet
				calendar.update_all(price: calendar_params[:price], status: calendar_params[:status])
			else
				# Sinon on execute cette ligne de code
				Calendar.create(

					menu_id: params[:menu_id],
					day: date,
					price: calendar_params[:price],
					status: calendar_params[:status]
				)
			end 
		end

		redirect_to chef_calendar_path
	end

	def chef
		@menus = current_user.menus

		params[:start_date] ||= Date.current.to_s
		params[:menu_id] ||= @menus[0] ? @menus[0].id : nil

		if params[:q].present?

			params[:start_date] = params[:q][:start_date]
			params[:menu_id] = params[:q][:menu_id]
		end

		@search = Reservation.ransack(params[:q])

		if params[:menu_id]
			# S'on a une menu present on vas les afficher dans le calendar
			@menu = Menu.find(params[:menu_id])
			start_date = Date.parse(params[:start_date])

			first_of_month = (start_date - 1.month).beginning_of_month
			end_of_month = (start_date + 1.month).end_of_month

			@events = @menu.reservations.joins(:user)
                      .select('reservations.*, users.fullname, users.image, users.email, users.uid')
                      .where('(start_date BETWEEN ? AND ?) AND status <> ?', first_of_month, end_of_month, 2)

            @events.each{ |e| e.image = avatar_url(e) }
            @days = Calendar.where("menu_id = ? AND day BETWEEN ? AND ?", params[:menu_id], first_of_month, end_of_month)

		else
			@menu = nil
			@events = [] #Array vide
			@days = []

		end
	end 

	private

		def calendar_params
			params.require(:calendar).permit([:price, :status, :start_date, :end_date])
		end
end

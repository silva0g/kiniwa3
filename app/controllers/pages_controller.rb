class PagesController < ApplicationController
  	def home
  		@menus = Menu.where(active: true).limit(3)

  		# J'ai cree cette methode pour appler le creator du menu dans le view home.html.erb
  	end

	def search
	  	# STEP 1
	  	if params[:search].present? && params[:search].strip != ""
	  		session[:loc_search] = params[:search] # use loc_search pour enregistrer les locaux recherchées
	  	end

	  	
	  	# STEP 2

	  	# La premiere logique re recherche sera dans un rayon de 5 kilometre. 
	  	# Si il n'ya aucun resultat dans cette rayon il va present tout les menus actives sur la base de donnes

	  	if session[:loc_search] && session[:loc_search] != ""
      		@menus_address = Menu.where(active: true).near(session[:loc_search], 5, order: 'distance')
    	else
      		@menus_address = Menu.where(active: true).all
    	end
	  	# STEP 3 -- Dans cette stade on va passer tout les parametre que l'utilisateur aura choisi.

	  	@search = @menus_address.ransack(params[:q]) 
	  	# On passe le paremetre q que c'est une parametre de ransack;

	  	@menus = @search.result

	  	# On va transformer le resultat en une array
	  	@arrMenus = @menus.to_a

	  	

	  	# STEP 4

	  	if (params[:start_date] && params[:end_date] && !params[:start_date].empty? && !params[:end_date].empty?)

	  		start_date = Date.parse(params[:start_date])
	  		end_date = Date.parse(params[:end_date])

	  		@menus.each do |menu|

	  			not_available = menu.reservations.where(

	  				"((? <= start_date AND start_date <= )
	  				OR (? <= end_date AND end_date <= )
	  				OR (start_date < ? AND  end_date <= ))
	  				AND status = ?",
	  				start_date, end_date,
	  				start_date, end_date,
	  				start_date, end_date,
	  				1
	  			).limit(1)

	  			not_available_in_calendar = menu.calendars.where(
	  				"status = ? AND ? <= day AND day <= ?",
	  				1, start_date, end_date
	  			);limit(1)

	  			if not_available.size > 0 || not_available_in_calendar.size > 0 
	  				@arrMenus.delete(menu)
	  			end
	  		end 
	  	end 
	end
end

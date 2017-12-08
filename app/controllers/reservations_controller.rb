class ReservationsController < ApplicationController
	# --- Kinywa 2
	# Avant de faire une reservation l'utitlisateur dois etre connecté
	before_action :authenticate_user!

	##### Kinywa 3
	##### cette methode permet de utilizer le variables:
	##### @reservation 
	##### à l'interier de la fonction set_reservation
	##### de la fonction approve et decline
	before_action :set_reservation, only: [:approve, :decline]

	##### Kinywa 2 
	##### On va creer une nouvelle methode
	def create
		menu = Menu.find(params[:menu_id])

		# Si l'utilisateu est est le chef d'un menu , il ne peut pas commander son menu
		if current_user == menu.user

			flash[:alert] = "Vous ne pouvez pas commander une prestation à vous meme!"
		elsif current_user.stripe_id.blank?
			flash[:alert] = "Veuilez reinseignez voz methode de payement."
			return redirect_to payment_method_path
		else

			start_date = Date.parse(reservation_params[:start_date])
			end_date = Date.parse(reservation_params[:end_date])
			start_time = Time.parse(reservation_params[:start_time])
			#convive = reservation_params[:convive]
			days = (end_date - start_date).to_i + 1
		
		

			@reservation = current_user.reservations.build(reservation_params)
			@reservation.menu = menu
			@reservation.price = menu.price
			@reservation.total = (menu.price * @reservation.convive) + total_products
			
			#@reservation.save


			if @reservation.Waiting!
				if menu.Request?
					flash[:notice] = "Demande envoyé avec success!"
				else
					#@reservation.Approved!
					charge(menu, @reservation)
					#flash[:notice] = "Demande de prestation crée avec success!"
				end
			else
				flash[:alert] = "Impossible passé la commande de prestation!"
			end

			create_reservation_products @reservation if @reservation.persisted?
		end

		redirect_to menu
	end


	def vos_commandes
		# --- Kinywa 2
		# Fonction pour afficher les commandes 
		@commandes = current_user.reservations.order(start_date: :asc)
	end

	def vos_prestations
		# --- Kinywa 2
		# Fonction pour afficher les prestations
		#On va chercher tout le smenu que appartien a cet utilisateur
		@menus = current_user.menus
	end


	

	def approve
		# --- Kinywa 3
		# Fonction pour accepter une commande de prestation
		charge(@reservation.menu, @reservation)
		redirect_to vos_prestations_path
	end 

	def decline
		# --- Kinywa 3
		# Fonction pour Rejecter une commande de prestation
		@reservation.Declined!
		redirect_to vos_prestations_path
	end

	
	private

	def total_products
		cart = session[:cart]
		total = 0
		cart.each do |c|
			product = Product.find(c[0])
			total = total + (product.price * c[1].to_i)
		end
		total
	end

	def create_reservation_products(reservation)
		cart = session[:cart]
		cart.each do |c|
			product = Product.find(c[0])
			ReservationProduct.create(reservation: reservation, product: product, quantity: c[1])
		end
	end



		def send_sms(menu, reservation)
			@client = Twilio::REST::Client.new
      		@client.messages.create(
        		from: '+33757903975 ',
        		to: menu.user.phone_number,
        		body: "#{reservation.user.fullname} à reservé une commande de prestation de '#{menu.listing_name}'"
      		)
		end 

		def charge(menu, reservation)
			if !reservation.user.stripe_id.blank? # Si la reservation n'est pas vide
				customer = Stripe::Customer.retrieve(reservation.user.stripe_id)
				binding.pry
				charge = Stripe::Charge.create(
					:customer => customer.id,
					:amount => reservation.total * 100,
					:description => menu.listing_name,
					:currency => "usd",
					:destination => {
						:amount => reservation.total * 80, # 80 % du total de chaque menu sont destiné aux chefs
						:account => menu.user.merchant_id   # identifiant du chef
					}
				)

				if charge
					reservation.Approved!
					ReservationMailer.send_email_to_client(reservation.user, menu).deliver_later if reservation.user.setting.enable_email # Quand la commande est approuvé envoye un email de notification au client
					send_sms(menu, reservation) if menu.user.setting.enable_sms # Quand la commande est approuvé envoye une message de notification au chef
					flash[:notice] = "Commande de prestation enregistré avec success"
				else
					reservation.Declined!
					flash[:alert] = "Impossible de valider la commande. Changez de carte!!!"
				end
			end
		rescue Stripe::CardError => e
			reservation.declined!
			flash[:alert] = e.message
		end 

		def set_reservation
			# --- Kinywa 3 
			# Fonction pour recupere les reservation de la base de donnees 
			# en fonction de l'id de reservation
			@reservation = Reservation.find(params[:id])
		end

		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date, :start_time, :convive)
		end
end
class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@menus = @user.menus

		# Montrer tout les notes de clients pour les chefs
		@client_reviews = Review.where(type: "ClientReview", chef_id: @user.id)

		# Montrer tout les notes de chefs pour les clients
		@chef_reviews = Review.where(type: "ChefReview", client_id: @user.id)
	end

	def update_phone_number
		current_user.update_attributes(user_params)
		current_user.generate_pin
		current_user.send_pin
		redirect_to edit_user_registration_path, notice: "Enregistrée..."

	# Si il ya quelque chose qui s'est mal passée on execute cette snippet
	rescue Exception => e
		redirect_to edit_user_registration_path, alert: "#{e.message}"
	end

	def verify_phone_number
		current_user.verify_pin(params[:user][:pin])

		if current_user.phone_verified
			flash[:notice] = "Votre numéro de télephone est verifié."
		else
			flash[:alert] = "Impossible vérier votre numéro. Essayez une autre numéro!"
		end

		redirect_to edit_user_registration_path

	# Si il ya quelque chose qui s'est mal passée on execute cette snippet
	rescue Exception => e
		redirect_to edit_user_registration_path, alert: "#{e.message}"
	end

	# --- STRIPE ---
	def payment

	end

	# methode pour envoyer de l'argent aux chefs partenaires
	def payout
		if !current_user.merchant_id.blank?
  			account = Stripe::Account.retrieve(current_user.merchant_id)
  			@login_link = account.login_links.create()
		end
    end
    


	def add_card
		if current_user.stripe_id.blank?
			customer = Stripe::Customer.create(
				email: current_user.email
			)
			current_user.stripe_id = customer.id
			current_user.save

			# Add Credit Card to Stripe
			customer.sources.create(source: params[:stripeToken])
		else
			# Si l'utilisateur à une compte stripe on va juste le reinseignez
			customer = Stripe::Customer.retrieve(current_user.stripe_id)
			customer.source = params[:stripeToken]
			customer.save
		end


		flash[:notice] = "Votre carte est enregistrée avec success."
		redirect_to payment_method_path
	rescue Stripe::CardError => e
		flash[:alert] = e.message
		redirect_to payment_method_path
	end

	private

	def user_params
		params.require(:user).permit(:phone_number, :pin)
	end
end

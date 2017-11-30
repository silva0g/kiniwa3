class RegistrationsController < Devise::RegistrationsController
	# On ajout cette methode pour empecher la demande de mot de passe lors de l'edition du profil utilisateur
	protected
		def update_resource(resource, params)
			resource.update_without_password(params)
		end

		# Maintenant on va dire à Devise de cette changement.
		# On va ajouter sur le routes.rb la commande suivante: registrations: 'registrations'

end
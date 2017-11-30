# Ici on va definir les environment pour les methodes de payement et remboursements
Rails.configuration.stripe = {
	:publishable_key => 'pk_test_Ts4Dl3yravZUqbDVxFbDFqLq',
	:secret_key => 'sk_test_fkVQKyjfwUJmNnYJB9pSFuts'
}


#Stripe.api_key = "sk_test_vrnZZK3kK8xfZjeDqrvWJYvb"

Stripe.api_key = Rails.configuration.stripe[:secret_key]
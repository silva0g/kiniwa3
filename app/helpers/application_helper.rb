module ApplicationHelper

	def avatar_url(user)	
		if user.image
			"http://graph.facebook.com/#{user.uid}/picture?type=small"
		else
			gravatar_id = Digest::MD5::hexdigest(user.email).downcase
			"https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
			#"default_avatar.png"
		end	
	end

	def stripe_express_path
		"https://connect.stripe.com/express/oauth/authorize?response_type=code&client_id=ca_BYV18C5W1Cye9Ec2q490jqQLXlQ61TOm&scope=read_write"
	end	
end

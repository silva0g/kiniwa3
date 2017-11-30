class Reservation < ApplicationRecord
  #------Kinywa3 -------
  enum status: {Waiting: 0, Approved: 1, Declined: 2}

  # ----- Pour les Notifications --------
  after_create_commit :create_notification


	#---- Kinywa2 ------	
  belongs_to :user
  belongs_to :menu

	scope :current_week_revenue, -> (user) {
	    joins(:menu)
	    .where("menus.user_id = ? AND reservations.updated_at >= ? AND reservations.status = ?", user.id, 1.week.ago, 1)
	    .order(updated_at: :asc)
	 }
  #has_many :convives

  # ----- Pour les Notifications --------
  private

  	def create_notification
  		#On va checker le type de menu:
  		type = self.menu.Instant? ? "Nouvelle commande de prestation" : "Nouvelle demande de prestation"
  		client = User.find(self.user_id)

  		Notification.create(content: "#{type} from #{client.fullname}", user_id: self.menu.user_id)
  	end
end

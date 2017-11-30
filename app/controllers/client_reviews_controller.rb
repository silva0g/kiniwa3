class ClientReviewsController < ApplicationController

	def create
    # Step 1: Check if the reservation exist (room_id, host_id, host_id)

    # Step 2: Check if the current host already reviewed the guest in this reservation.

    @reservation = Reservation.where(
                    id: client_review_params[:reservation_id],
                    menu_id: client_review_params[:menu_id]
                   ).first

    if !@reservation.nil? && @reservation.menu.user.id == client_review_params[:chef_id].to_i

      @has_reviewed = ClientReview.where(
                        reservation_id: @reservation.id,
                        chef_id: client_review_params[:chef_id]
                      ).first

      if @has_reviewed.nil?
          # Allow to review
          @client_review = current_user.client_reviews.create(client_review_params)
          flash[:success] = "Note crée avec success..."
      else
          # Already reviewed
          flash[:success] = "Vous avez déja noté cette chef"
      end
    else
      flash[:alert] = "Reservation non trouvé"
    end

    redirect_back(fallback_location: request.referer)
  end

  def destroy
    @client_review = Review.find(params[:id])
    @client_review.destroy

    redirect_back(fallback_location: request.referer, notice: "Efacée avec success ...!")
  end

  private
    def client_review_params
      params.require(:client_review).permit(:comment, :star, :menu_id, :reservation_id, :chef_id)
    end
end
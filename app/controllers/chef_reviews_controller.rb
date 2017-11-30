class ChefReviewsController < ApplicationController

	def create
    # Step 1: Check if the reservation exist (room_id, guest_id, host_id)

    # Step 2: Check if the current host already reviewed the guest in this reservation.

    @reservation = Reservation.where(
                    id: chef_review_params[:reservation_id],
                    menu_id: chef_review_params[:menu_id],
                    user_id: chef_review_params[:client_id]
                   ).first

    if !@reservation.nil?

      @has_reviewed = ChefReview.where(
                        reservation_id: @reservation.id,
                        client_id: chef_review_params[:client_id]
                      ).first

      if @has_reviewed.nil?
          # Allow to review
          @chef_review = current_user.chef_reviews.create(chef_review_params)
          flash[:success] = "Note crée..."
      else
          # Already reviewed
          flash[:success] = "Vous avez deja noté cette chef"
      end
    else
      flash[:alert] = "Reservation non trouvée"
    end

    redirect_back(fallback_location: request.referer)
  end

  def destroy
    @chef_review = Review.find(params[:id])
    @chef_review.destroy

    redirect_back(fallback_location: request.referer, notice: "Efacée...!")
  end

  private
    def chef_review_params
      params.require(:chef_review).permit(:comment, :star, :menu_id, :reservation_id, :client_id)
    end
end
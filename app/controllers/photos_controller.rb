class PhotosController < ApplicationController

	def create
		@menu = Menu.find(params[:menu_id])
		if params[:images]
			params[:images].each do |img|
				@menu.photos.create(image: img)
			end

			@photos = @menu.photos
			redirect_back(fallback_location: request.referer, notice: "Enregistée...")
		end
	end

	def destroy
		@photo = Photo.find(params[:id]) # Pour chercer les photos par id
		@menu = @photo.menu #Pour trover les photos de cette menu

		@photo.destroy # Pour effacer le photo deja selectionnée
		@photos = Photo.where(menu_id: @menu.id) # Pour avoir la liste des photos que on n as pas effacé

		respond_to :js
	end
end
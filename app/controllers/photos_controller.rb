class PhotosController < ApplicationController

	def create
		klass = params[:imageable_type].constantize
		@imageable = klass.find(params[:imageable_id])
		if params[:images]
			params[:images].each do |img|
				@imageable.photos.create(image: img)
			end

			@photos = @imageable.photos
			redirect_back(fallback_location: request.referer, notice: "Enregistée...")
		end
	end

	def destroy
		@photo = Photo.find(params[:id]) # Pour chercer les photos par id
		@imageable = @photo.imageable #Pour trover les photos de cette menu

		@photo.destroy # Pour effacer le photo deja selectionnée
		#@photos = Photo.where(imageable_id: @imageable.id) # Pour avoir la liste des photos que on n as pas effacé
		@photos = @imageable.photos # Pour avoir la liste des photos que on n as pas effacé

		respond_to :js
	end
end
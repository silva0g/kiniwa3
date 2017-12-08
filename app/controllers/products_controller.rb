class ProductsController < ApplicationController
    before_action :set_product, except: [:index, :new, :create]

  # Avant que l'utilisateur cree un product il faut authentiquer sur le site, on met cette ligne pour cela
  before_action :authenticate_user!, except: [:show]

  before_action :is_authorised, only: [:listing, :pricing, :description, :photo_upload, :amenities, :location, :update]
  

  def index
    @products = current_user.products
  end

  def new
    # cette methode est apple quand le User veur creer une nouvele product
    @product = current_user.products.build
  end

  def create
    if !current_user.is_active_chef
      return redirect_to payout_method_path, alert: "Veuilez connecter à stripe express avant..."
    end 

    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to listing_product_path(@product), notice: "Enregistré..." 
    else
      flash[:alert] = "Il ya quelque chose que s'est mal passe"
      render :new 
    end
  end

  def listing
   
  end

  def show # method pour montre les products
    @photos = @product.photos
    
    # Definition des notes de clients
    # @client_reviews = @product.client_reviews

  end 

  def pricing
    
  end

  def description
    
  end

  def photo_upload
    @photos = @product.photos
  end

  def update
    new_params = product_params
    new_params = product_params.merge(active: true) if is_ready_product

    #if @product.update(product_params)
    if @product.update(new_params)
      flash[:notice] = "Enregistré..."
    else
      flash[:notice] = "Un problème a survenu, le changement n'as pas eté enregistré..."  
    end
      # Si jamais quelque chose passe mal, cette ligne nos ira envoyer la on à commencé
      redirect_back(fallback_location: request.referer)
  end

  # --- Pour les Reservations -->


  private 

    def set_product
       @product = Product.find(params[:id])
    end

    def is_authorised
      redirect_to root_path, alert: "Vous n'avez pas de permission" unless current_user.id == @product.user.id 
    end

    def is_ready_product
      !@product.active && !@product.price.blank? && !@product.listing_name.blank? && !@product.photos.blank?
    end

    def product_params
      # Ici on declare quel sont les parameters que sera changé quand l'user veut creer une product
      params.require(:product).permit(:product_type, :listing_name, :summary, :price, :active)
    end
end

class MenusController < ApplicationController
  # On a appeler set_menu pour etre lance avant tout les methodes
  before_action :set_menu, except: [:index, :new, :create]

  # Avant que l'utilisateur cree un menu il faut authentiquer sur le site, on met cette ligne pour cela
  before_action :authenticate_user!, except: [:show]

  before_action :is_authorised, only: [:listing, :pricing, :description, :photo_upload, :amenities, :location, :update]
  


  def index
    @menus = current_user.menus
  end

  def new
    # cette methode est apple quand le User veur creer une nouvele menu
    @menu = current_user.menus.build
  end

  def create
    if !current_user.is_active_chef
      return redirect_to payout_method_path, alert: "Veuilez connecter à stripe express avant..."
    end 

    @menu = current_user.menus.build(menu_params)
    if @menu.save
      redirect_to listing_menu_path(@menu), notice: "Enregistré..." 
    else
      flash[:alert] = "Il ya quelque chose que s'est mal passe"
      render :new 
    end
  end

  def listing
   
  end

  def show # method pour montre les menus
    @photos = @menu.photos
    
    # Definition des notes de clients
    @client_reviews = @menu.client_reviews

  end 

  def pricing
    
  end

  def description
    
  end

  def photo_upload
    @photos = @menu.photos
  end

  def amenities
  end

  def location
  end

  def update
    new_params = menu_params
    new_params = menu_params.merge(active: true) if is_ready_menu

    #if @menu.update(menu_params)
    if @menu.update(new_params)
      flash[:notice] = "Enregistré..."
    else
      flash[:notice] = "Un problème a survenu, le changement n'as pas eté enregistré..."  
    end
      # Si jamais quelque chose passe mal, cette ligne nos ira envoyer la on à commencé
      redirect_back(fallback_location: request.referer)
  end

  # --- Pour les Reservations -->
  def preload
    today = Date.today

    # Add this to define the now time 
    #now = Time.now
    
    reservations = @menu.reservations.where("(start_date >= ? OR end_date >= ?) AND status =?", today, today, 1)
    unavailable_dates = @menu.calendars.where("status = ? AND day > ?", 1, today)
    special_dates = @menu.calendars.where("status = ? AND day > ? AND price <> ?", 0, today, @menu.price)

    render json: {
      # Here we pass the variables to the frontEnd via json:
      reservations: reservations,
      unavailable_dates: unavailable_dates,
      special_dates: special_dates
    }
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    #start_time = Time.parse(params[:start_time])

    output = {
      conflict: is_conflict(start_date, end_date, @menu)
    }

    render json: output
  end

  private 

    def is_conflict(start_date, end_date, menu)
      check = menu.reservations.where("(? < start_date AND end_date < ?) AND status = ?", start_date, end_date, 1)
      check_calendar = menu.calendars.where("day BETWEEN ? AND ? AND status = ?", start_date, end_date, 1).limit(1)
      check.size > 0 || check_calendar.size > 0 ? true : false
    end

    def set_menu
       @menu = Menu.find(params[:id])
    end

    def is_authorised
      redirect_to root_path, alert: "Vous n'avez pas de permission" unless current_user.id == @menu.user.id 
    end

    def is_ready_menu
      !@menu.active && !@menu.price.blank? && !@menu.listing_name.blank? && !@menu.photos.blank? && !@menu.address.blank?
    end

    def menu_params
      # Ici on declare quel sont les parameters que sera changé quand l'user veut creer une menu
      params.require(:menu).permit(:menu_type, :assiete_type, :servings, :listing_name, :summary, :address, :is_salee, :is_sucree, :is_gluten, :is_epicee, :price, :active, :instant)
    end
end

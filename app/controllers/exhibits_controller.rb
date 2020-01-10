class ExhibitsController < ApplicationController
  before_action :set_exhibit, except: [:index, :new, :create]
  before_action :move_index, except: :index
  before_action :validate_user, only: [:show, :edit, :update, :destroy]

  
  def index
    @exhibits = Exhibit.includes(:images).order('created_at DESC')
    @exhibits = Exhibit.all.limit(10).order(id: "DESC")

  end

  def new
    @exhibit = Exhibit.new
    @exhibit.images.new
  end

  def create
    @exhibit = Exhibit.new(exhibit_params)
    @exhibit.user_id = current_user.id
    if @exhibit.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end
  
  def edit
  end

  def update
    if @exhibit.update(exhibit_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @exhibit.user_id == current_user.id && @exhibit.destroy
      redirect_to root_path
    else
      redirect_to show_exhibits_path(exhibit)
      flash[:alert] = '商品削除に失敗しました'
    end
  end

  private

  def exhibit_params
    params.require(:exhibit).permit(:name, :detail, :category_id, :condition_id, :delicharge_id, :shipfrom_id, :delidate_id, :price, images_attributes: [:src, :_destroy, :id])
  end

  def set_exhibit
    @exhibit = Exhibit.find(params[:id])
  end

  def move_index
    redirect_to action: :index unless user_signed_in?

  end

  def validate_user
    if @exhibit.user_id != current_user.id
      redirect_to root_path
    end
  end

end

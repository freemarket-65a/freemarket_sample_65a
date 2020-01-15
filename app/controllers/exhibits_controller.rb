class ExhibitsController < ApplicationController
  before_action :set_exhibit, except: [:index, :new, :create, :get_category_children, :get_category_grandchildren]
  # before_action :set_exhibit, except: [:index, :new, :create]
  before_action :move_index, except: :index

  before_action :validate_user, only: [:show, :edit, :update, :destroy]
  before_action :set_card, only: [:buy, :pay]

  require 'payjp'
  
  def index
    @exhibits = Exhibit.includes(:images).order('created_at DESC')
    @exhibits = Exhibit.all.limit(10).order(id: "DESC")

  end

  def new
    @exhibit = Exhibit.new
    @exhibit.images.new
    #データベースから、親カテゴリーのみ抽出し、配列化
    @category_parent_array = Category.where(ancestry: nil)
  end

    # 以下全て、formatはjsonのみ
    # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
      @category_children = Category.find_by(id: "#{params[:parent_name]}", ancestry: nil).children
  end

    # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
      @category_grandchildren = Category.find("#{params[:child_id]}").children
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
    @exhibit = Exhibit.find(params[:id])
    
    @exhibits = Exhibit.includes(:images).order('created_at DESC')
    @exhibits = Exhibit.all.limit(3).order(id: "DESC")
  end

  def edit
    # @exhibit = Exhibit.find(params[:id])
    @category_parent_array = Category.where(ancestry: nil)
  end

  def update
    if @exhibit.update(exhibit_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  

  def buy
  
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if set_card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "index"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    # card = Card.where(user_id: current_user.id).first
    Payjp::Charge.create(
    :amount => @exhibit.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => set_card.customer_id, #顧客ID
    :currency => 'jpy', #日本円   
    )
    redirect_to action: 'index' #完了画面に移動
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

  
  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def exhibit_params
    params.require(:exhibit).permit(:name, :detail, :category_id, :condition_id, :delicharge_id, :shipfrom_id, :delidate_id, :status, :price, images_attributes: [:src, :_destroy, :id])
  end

  def set_exhibit
    @exhibit = Exhibit.find(params[:id])
  end

  def move_index
    redirect_to action: :index unless user_signed_in?

  end

  def validate_user

  end

end

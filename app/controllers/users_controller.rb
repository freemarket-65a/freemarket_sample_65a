class UsersController < ApplicationController
  before_action :set_card

  def mypage
  end

  def profile
  end

  def credit
    
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
    #保管した顧客IDでpayjpから情報取得
    customer = Payjp::Customer.retrieve(@card.customer_id)
    #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    @default_card_information = customer.cards.retrieve(@card.card_id)
  end

  def logout
  end

  def identification
  end

  private
  
  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

end

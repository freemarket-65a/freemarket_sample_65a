class SignupController < ApplicationController

  before_action :validates_step2, only: :step3
  before_action :validates_step3, only: :step4
  before_action :validates_step4, only: :step5

  require "payjp"
  Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)

  def step1
    @user = User.new
  end

  def step2
    @user = User.new
  end

  def step3
    @user = User.new
  end

  def step4
    @user = User.new
  end

  def step5
    @user = User.new
    card = Card.where(user_id: session[:id])
  end

  def validates_step2
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name] = user_params[:last_name]
    session[:family_name] = user_params[:family_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:family_name_kana] = user_params[:family_name_kana]
    session[:birthday_year] = user_params[:birthday_year]
    session[:birthday_month] = user_params[:birthday_month]
    session[:birthday_day] = user_params[:birthday_day]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      family_name: session[:family_name], 
      last_name_kana: session[:last_name_kana], 
      family_name_kana: session[:family_name_kana], 
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day],
      phonenumber: "09012345678",
    )
    render '/signup/step2' unless @user.valid?
  end

  def validates_step3
    session[:phonenumber] = user_params[:phonenumber]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      family_name: session[:family_name], 
      last_name_kana: session[:last_name_kana], 
      family_name_kana: session[:family_name_kana], 
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day],
      phonenumber: session[:phonenumber],
    )
    render '/signup/step3' unless @user.valid?
  end

  def validates_step4
    session[:postal] = params[:user][:addresses][:postal]
    session[:prefecture] = params[:user][:addresses][:prefecture]
    session[:city] = params[:user][:addresses][:city]
    session[:address] = params[:user][:addresses][:address]
    session[:building] = params[:user][:addresses][:building]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      family_name: session[:family_name], 
      last_name_kana: session[:last_name_kana], 
      family_name_kana: session[:family_name_kana], 
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day],
      phonenumber: session[:phonenumber],
    )
    @address = Address.new(
      postal: session[:postal],
      prefecture: session[:prefecture],
      city: session[:city],
      address: session[:address],
      building: session[:building],
    )
    render '/signup/step4' unless @user.valid? && @address.valid?
  end

  def create
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      family_name: session[:family_name], 
      last_name_kana: session[:last_name_kana], 
      family_name_kana: session[:family_name_kana], 
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day],
      phonenumber: session[:phonenumber]
    )
    @address = Address.new(
      postal: session[:postal],
      prefecture: session[:prefecture],
      city: session[:city],
      address: session[:address],
      building: session[:building],
    )

    if @user.save
      @address[:user_id] = @user.id
      @address.save
      session[:id] = @user.id  # ここでidをsessionに入れることでログイン状態に持っていける。
      sign_in User.find(session[:id]) unless user_signed_in?

      if params['payjp-token'].blank?
        redirect_to action: "new"
      else
        customer = Payjp::Customer.create(
        card: params['payjp-token']
        ) #念の為metadataにuser_idを入れましたがなくてもOK
        @card = Card.new(user_id: session[:id], customer_id: customer.id, card_id: customer.default_card)
        if @card.save
        else
          redirect_to action: "pay"
        end
      end

      redirect_to complete_signup_signup_index_path
    else
      render '/signup/step1'
    end
  end

  # def complete_signup
  #   sign_in User.find(session[:id]) unless user_signed_in?
  # end

  private
  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password, 
      :password_confirmation, 
      :family_name,
      :last_name, 
      :family_name_kana, 
      :last_name_kana, 
      :birthday_year, 
      :birthday_month, 
      :birthday_day,
      :phonenumber,
      addresses_attributes: [:id, :postal, :prefecture, :city, :address, :building]
    )
  end

end

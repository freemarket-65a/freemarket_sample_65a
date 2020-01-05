class SignupController < ApplicationController

  def step1
    @user = User.new
    # @user.build_address
  end

  def step2
    session[:user_params] = user_params  #userモデルの値をぶっこむ。
    session[:addresses_attributes_after_step1] = user_params[:addresses_attributes]  # profileモデルの値をぶっこむ。
    @user = User.new
    # @user.build_adderss
  end

  def create
    @user = User.new(session[:user_params])  # ここでuserモデルのsessionを引数で渡す。
    @user.build_addresses(session[:addresses_attributes_after_step1])  # ここでprofileモデルのsessionを引数で渡す。
    @user.build_addresses(user_params[:addresses_attributes])  # 今回のビューで入力された情報を代入。
    if @user.save
      session[:id] = @user.id  # ここでidをsessionに入れることでログイン状態に持っていける。
      redirect_to complete_signup_signup_index_path
    else
      render '/signup/step1'
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password, 
      :password_confirmation, 
      :family_name_kanji,
      :first_name_kanji, 
      :family_name_kana, 
      :first_name_kana, 
      :birth_year, 
      :birth_month, 
      :birth_day,
      address_attributes: [:id, :postal, :prefecture, :city, :address, :building]
    )
  end

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address
  belongs_to :card , optional: true
  accepts_nested_attributes_for :address

  VALID_EMAIL_REGEX =                 /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :nickname,                presence: true
    validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
    validates :password,                presence: true, length: {minimum: 6, maximum: 128},on: :save_to_session_before_phone
    validates :password_confirmation,   presence: true, length: {minimum: 6, maximum: 128},on: :save_to_session_before_phone
    validates :last_name,               presence: true
    validates :family_name,             presence: true
    validates :last_name_kana,          presence: true
    validates :family_name_kana,        presence: true
    validates :birthday_year,           presence: true
    validates :birthday_month,          presence: true
    validates :birthday_day,            presence: true

    validates :phonenumber,             presence: true

end

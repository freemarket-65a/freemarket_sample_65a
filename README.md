# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
## usersテーブル

|Column        |Type       |Options                        |
|--------------|-----------|-------------------------------|
|nickname      |string     |null: false , add_index        |
|email         |string     |null: false                    |
|password      |string     |null: false                    |
|family_name   |string     |null: false                    |
|last_name     |string     |null: false                    |
|last_name_kana|string     |null: false                    |
|last_name_kana|string     |null: false                    |
|birthday_year |integer    |null: false                    |
|birthday_month|integer    |null: false                    |
|birthday_day  |integer    |null: false                    |
|phonenumber   |string     |null: false                    |

### Association
- has_many :comments
- has_many :products
- has_one  :card, dependent: destroy
- has_one  :address, dependent: destroy


## addressesテーブル

|Column       |Type       |Options                        |
|-------------|-----------|-------------------------------|
|user_id      |references |null: false, foreign_key: true |
|postal       |integer    |null: false                    |
|prefecture   |string     |null: false                    |
|city         |string     |null: false                    |
|address      |string     |null: false                    |
|building     |string     |                               |

### Association
belongs_to :user


## cardsテーブル

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|user_id         |references  |null: false, foreign_key: true |
|customer_id     |integer     |null: false                    |
|card_id         |integer     |null: false                    |

### Association
- belongs_to :user


## exhibitsテーブル

|Column           |Type        |Options                        |
|-----------------|------------|-------------------------------|
|user_id          |references  |null: false, foreign_key: true |
|category_id      |integer     |null: false, foreign_key: true |
|conditioin_id    |integer     |null: false                    |
|delicharge_id    |integer     |null: false                    |
|shipfrom_id      |integer     |null: false                    |
|delidate_id      |integer     |null: false                    |
|price            |integer     |null: false                    |
|name             |string      |null: false                    |
|details          |text        |null: false                    |
|status           |integer     |null: false                    |

### Association
- belongs_to :user
- has_many :images
- belongs_to :category


## imagesテーブル

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|product_id      |references  |null: false, foreign_key: true |
|src             |text        |null: false                    |

### Association
- belongs_to :exhibit


## categoriesテーブル

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|ancestry        |string      |null: false                    |
|name            |string      |null: false                    |

### Association
- has_many :exhibits
- has_ancestry


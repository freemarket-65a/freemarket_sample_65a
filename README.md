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

|Column       |Type       |Options                        |
|-------------|-----------|-------------------------------|
|nickname     |string     |null: false , add_index        |
|email        |string     |null: false                    |
|password     |string     |null: false                    |
|family_name  |string     |null: false                    |
|last_name    |string     |null: false                    |
|birthday     |integer    |null: false                    |

### Association
- has_many :comments
- has_many :products
- has_one  :pay, dependent: destroy
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


## paysテーブル

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|user_id         |references  |null: false, foreign_key: true |
|card_number     |integer     |null: false                    |
|year            |integer     |null: false                    |
|month           |integer     |null: false                    |
|name            |string      |null: false                    |
|security_number |integer     |null: false                    |

### Association
- belongs_to :user


## commentsテーブル

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|user_id         |references  |null: false, foreign_key: true |
|product_id      |references  |null: false, foreign_key: true |
|comment         |text        |null: false                    |

### Association
- belongs_to :user
- belongs_to :product


## productsテーブル

|Column           |Type        |Options                        |
|-----------------|------------|-------------------------------|
|user_id          |references  |null: false, foreign_key: true |
|category_id      |references  |null: false, foreign_key: true |
|brand_id         |references  |null: false, foreign_key: true |
|price            |integer     |null: false                    |
|name             |string      |null: false                    |
|registration_date|string      |null: false                    |
|shipping_charges |string      |null: false                    |
|shipping_area    |string      |null: false                    |

### Association
- belongs_to :user
- has_many :comments
- has_many :images
- belongs_to :category
- belongs_to :brand


## imagesテーブル

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|product_id      |references  |null: false, foreign_key: true |
|image           |text        |null: false                    |

### Association
- belongs_to :product


## categoriesテーブル

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|ancestry        |string      |null: false                    |
|name            |string      |null: false                    |

### Association
- has_many :products
- has_ancestry


## brandsテーブル

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|name            |string      |null: false                    |

### Association
- has_many :products

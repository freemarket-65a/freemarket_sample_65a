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
|famili_name  |string     |null: false                    |
|last_name    |string     |null: false                    |
|birthday     |integer    |null: false                    |
|products_id  |references |null: false, foreign_key: true |

### Association
- has_many :comments
- has_many :products
- has_one  :pay


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
|bland_id         |references  |null: false, foreign_key: true |
|price            |integer     |null: false                    |
|registration_date|string      |null: false                    |
|shipping_charges |string      |null: false                    |
|shipping_area    |string      |null: false                    |

### Association
- belongs_to :user
- has_many :comments
- has_many :images
- belongs_to :categorie
- belongs_to  :bland


## imagesテーブル

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|products_id     |references  |null: false, foreign_key: true |
|image           |text        |null: false                    |

### Association
- belongs_to :product


## categoriesテーブル

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|path            |integer     |null: false                    |
|ancestry        |string      |null: false                    |

### Association
- has_many :products
- has_ancestry


## blandsテーブル

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|path            |integer     |null: false                    |
|blamd           |string      |null: false                    |

### Association
- has_many :products







# テーブル設計

## users テーブル 

| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| name               | string     | null: false               |
| email              | string     | null: false, unique :true |
| encrypted_password | string     | null: false               |
| family_name        | string     | null: false               |
| first_name         | string     | null: false               |
| family_name_spell  | string     | null: false               |
| first_name_spell   | string     | null: false               |
| birth_date         | date       | null: false               |


### Association

- has_many :items
- has_one :buyer

## items テーブル 

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item_name          | string     | null: false                    |
| item_info          | text       | null: false                    |
| delivery_fee_id    | integer    | null: false                    |
| shipment_source_id | integer    | null: false                    |
| shipping_time_id   | integer    | null: false                    |
| price              | integer    | null: false                    |


### Association

- belongs_to :user
- belongs_to :buyer

## buyers テーブル 

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| item     | references | null: false, foreign_key: true |

### Association

- has_many :items
- belongs_to :user
- has_one :buyer_address

## buyer_addresses テーブル 

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postal_code    | integer    | null: false                    |
| prefecture_id  | integer    | null: false                    |
| municipality   | string     | null: false                    |
| address        | string     | null: false                    |
| phone_number   | string     | null: false                    |
| buyer          | references | null: false, foreign_key: true |


### Association

- belongs_to :buyer

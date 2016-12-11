class Withdraw < ActiveRecord::Base

	has_many :users
	has_many :seller_accounts

	validates :amount, presence: true
	validates :user_id, presence: true
	validates :seller_account_id,presence: true
	validates :status, presence: true

end
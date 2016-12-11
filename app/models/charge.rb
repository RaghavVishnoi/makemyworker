class Charge < ActiveRecord::Base

	has_many :buyer_accounts
	has_many :users
	has_many :requests

	validates :request_id, presence: true
	validates :user_id, presence: true
	validates :buyer_account_id, presence: true
	validates :status, presence: true
	validates :amount, presence: true


end
class Group < ActiveRecord::Base
	belongs_to :user

	attr_accessor :list_of_additional_emails

	def initialize 
		# @list_of_additional_emails = []
	end

end

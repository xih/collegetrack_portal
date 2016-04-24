class AddExtraEmailsToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :extra_emails, :string
  end
end

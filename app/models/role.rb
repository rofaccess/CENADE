class Role < ActiveRecord::Base
  paginates_per 20
  has_and_belongs_to_many :users, :join_table => :users_roles
  has_and_belongs_to_many :permissions
  belongs_to :resource,
             :polymorphic => true
    
  scopify

 
end

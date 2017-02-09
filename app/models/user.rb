class User < ActiveRecord::Base
  include Concerns::InstanceMethods
  extend Concerns::ClassMethods
  
  has_many :items 
  has_many :tags, through: :items 

  has_secure_password
end
class Tag < ActiveRecord::Base
  include Concerns::InstanceMethods
  extend Concerns::ClassMethods

  has_many :items 
  has_many :users, through: :items 
end
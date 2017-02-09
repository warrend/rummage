class Item < ActiveRecord::Base
  include Concerns::InstanceMethods
  extend Concerns::ClassMethods

  belongs_to :user
  belongs_to :tag

end
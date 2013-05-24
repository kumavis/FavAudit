class User < ActiveRecord::Base
  audited
  
  attr_accessible :fav_color, :fav_food, :name
end

class Like < ActiveRecord::Base
  attr_accessible :post_id, :user_id
  
  #define associations
  belongs_to :user
  belongs_to :post
end

class Post < ActiveRecord::Base
  attr_accessible :content, :title
  
  #define association
  belongs_to :user
end

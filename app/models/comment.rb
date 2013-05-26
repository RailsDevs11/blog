class Comment < ActiveRecord::Base
  attr_accessible :content
  
  #define validation
  validates :content, :presence => true
  
  #define associations
  belongs_to :post
  belongs_to :user
  
  #fetch name of comment's owner
  def comment_user
    self.user.full_name rescue ''
  end
    
  #fetch owner of comment
  def is_owner?(user_id)
    return (self.user.id === user_id)
  end
end

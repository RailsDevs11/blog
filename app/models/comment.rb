class Comment < ActiveRecord::Base
  attr_accessible :content
  
  #define associations
  belongs_to :post
  
  def comment_user
    self.post.user.full_name
  end
    
  def is_owner?(user_id)
    return (self.user.id === user_id)
  end
end
